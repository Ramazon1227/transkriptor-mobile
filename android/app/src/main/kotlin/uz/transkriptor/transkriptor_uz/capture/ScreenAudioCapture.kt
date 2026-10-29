package uz.transkriptor.transkriptor_uz.capture

import android.annotation.SuppressLint
import android.media.AudioAttributes
import android.media.AudioFormat
import android.media.AudioPlaybackCaptureConfiguration
import android.media.AudioRecord
import android.media.MediaCodec
import android.media.MediaCodecInfo
import android.media.MediaFormat
import android.media.MediaRecorder
import android.media.projection.MediaProjection
import android.os.Build
import android.os.SystemClock
import androidx.annotation.RequiresApi
import java.io.BufferedOutputStream
import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import kotlin.math.log10
import kotlin.math.max
import kotlin.math.min
import kotlin.math.sqrt

/**
 * What other apps play (media, games, unknown usages), optionally summed
 * with the microphone, encoded to AAC-LC and written as ADTS to [out].
 *
 * Apps can refuse playback capture (`allowAudioPlaybackCapture=false`,
 * or a usage such as VOICE_COMMUNICATION, which is never capturable), so
 * most call apps are silent here. [onSilent] fires once when nothing at
 * all came from playback for [SILENT_AFTER_MS].
 */
@RequiresApi(Build.VERSION_CODES.Q)
class ScreenAudioCapture(
    private val projection: MediaProjection,
    private val withMic: Boolean,
    private val out: File,
    private val onLevel: (level: Double, elapsedMs: Long) -> Unit,
    private val onSilent: () -> Unit,
    private val onFailure: (Throwable) -> Unit,
) {
    companion object {
        const val SAMPLE_RATE = 44100
        private const val CHANNELS = 1
        private const val BIT_RATE = 64000
        private const val FRAME = Adts.SAMPLES_PER_FRAME
        private const val SILENT_AFTER_MS = 5000L
        private const val FLOOR_DB = -50.0
    }

    private var playback: AudioRecord? = null
    private var mic: AudioRecord? = null
    private var codec: MediaCodec? = null
    private var output: BufferedOutputStream? = null
    private var thread: Thread? = null

    @Volatile private var running = false
    @Volatile private var samples = 0L

    val elapsedMs: Long get() = samples * 1000L / SAMPLE_RATE

    /** Throws when the capture cannot start (no permission, refused by the system). */
    @SuppressLint("MissingPermission") // RECORD_AUDIO is checked before the service starts.
    fun start() {
        val format = AudioFormat.Builder()
            .setEncoding(AudioFormat.ENCODING_PCM_16BIT)
            .setSampleRate(SAMPLE_RATE)
            .setChannelMask(AudioFormat.CHANNEL_IN_MONO)
            .build()
        val minBuffer = AudioRecord.getMinBufferSize(
            SAMPLE_RATE, AudioFormat.CHANNEL_IN_MONO, AudioFormat.ENCODING_PCM_16BIT,
        )
        val bufferBytes = max(minBuffer * 4, FRAME * 2 * 8)
        val config = AudioPlaybackCaptureConfiguration.Builder(projection)
            .addMatchingUsage(AudioAttributes.USAGE_MEDIA)
            .addMatchingUsage(AudioAttributes.USAGE_GAME)
            .addMatchingUsage(AudioAttributes.USAGE_UNKNOWN)
            .build()
        try {
            val pb = AudioRecord.Builder()
                .setAudioFormat(format)
                .setBufferSizeInBytes(bufferBytes)
                .setAudioPlaybackCaptureConfig(config)
                .build()
            playback = pb
            if (pb.state != AudioRecord.STATE_INITIALIZED) throw IOException("playback capture not initialised")
            if (withMic) {
                // VOICE_COMMUNICATION turns on the device's echo canceller,
                // so the speaker's own sound is not recorded twice.
                val m = AudioRecord.Builder()
                    .setAudioSource(MediaRecorder.AudioSource.VOICE_COMMUNICATION)
                    .setAudioFormat(format)
                    .setBufferSizeInBytes(bufferBytes)
                    .build()
                mic = m
                if (m.state != AudioRecord.STATE_INITIALIZED) throw IOException("microphone not initialised")
            }
            val mediaFormat = MediaFormat.createAudioFormat(
                MediaFormat.MIMETYPE_AUDIO_AAC, SAMPLE_RATE, CHANNELS,
            ).apply {
                setInteger(MediaFormat.KEY_AAC_PROFILE, MediaCodecInfo.CodecProfileLevel.AACObjectLC)
                setInteger(MediaFormat.KEY_BIT_RATE, BIT_RATE)
                setInteger(MediaFormat.KEY_MAX_INPUT_SIZE, FRAME * 2 * 4)
            }
            val c = MediaCodec.createEncoderByType(MediaFormat.MIMETYPE_AUDIO_AAC)
            codec = c
            c.configure(mediaFormat, null, null, MediaCodec.CONFIGURE_FLAG_ENCODE)
            c.start()
            output = BufferedOutputStream(FileOutputStream(out), 1 shl 16)
            pb.startRecording()
            mic?.startRecording()
        } catch (e: Throwable) {
            release()
            throw e
        }
        running = true
        thread = Thread(::loop, "screen-audio").also { it.start() }
    }

    /** Drains the encoder and closes the file. Blocks; call off the main thread. */
    fun stop() {
        running = false
        thread?.join(5000)
        thread = null
        release()
    }

    private fun loop() {
        val pcm = ShortArray(FRAME)
        val micPcm = ShortArray(FRAME)
        val info = MediaCodec.BufferInfo()
        val startedAt = SystemClock.elapsedRealtime()
        var heardPlayback = false
        var silentReported = false
        var lastLevel = 0L
        var lastFlush = startedAt
        var sumSquares = 0.0
        var levelSamples = 0
        try {
            while (running) {
                val pb = playback ?: break
                val n = pb.read(pcm, 0, FRAME, AudioRecord.READ_BLOCKING)
                if (n < 0) throw IOException("playback read failed: $n")
                if (n == 0) continue
                if (!heardPlayback) {
                    for (i in 0 until n) if (pcm[i].toInt() != 0) { heardPlayback = true; break }
                }
                mic?.let { m ->
                    val got = m.read(micPcm, 0, n, AudioRecord.READ_BLOCKING)
                    for (i in 0 until min(n, max(got, 0))) {
                        val s = pcm[i] + micPcm[i]
                        pcm[i] = s.coerceIn(Short.MIN_VALUE.toInt(), Short.MAX_VALUE.toInt()).toShort()
                    }
                }
                for (i in 0 until n) {
                    val v = pcm[i] / 32768.0
                    sumSquares += v * v
                }
                levelSamples += n
                encode(pcm, n, info)
                samples += n

                val now = SystemClock.elapsedRealtime()
                if (now - lastLevel >= 100) {
                    val rms = sqrt(sumSquares / max(levelSamples, 1))
                    val db = if (rms > 0) 20 * log10(rms) else FLOOR_DB
                    onLevel(((db - FLOOR_DB) / -FLOOR_DB).coerceIn(0.0, 1.0), elapsedMs)
                    sumSquares = 0.0
                    levelSamples = 0
                    lastLevel = now
                }
                if (now - lastFlush >= 1000) {
                    // Whatever reached the kernel survives the process being killed.
                    output?.flush()
                    lastFlush = now
                }
                if (!heardPlayback && !silentReported && now - startedAt >= SILENT_AFTER_MS) {
                    silentReported = true
                    onSilent()
                }
            }
            finishEncoding(info)
        } catch (e: Throwable) {
            running = false
            runCatching { output?.flush() }
            onFailure(e)
        }
    }

    private fun encode(pcm: ShortArray, count: Int, info: MediaCodec.BufferInfo) {
        val c = codec ?: return
        var offset = 0
        while (offset < count) {
            val index = c.dequeueInputBuffer(10_000)
            if (index < 0) {
                drain(info, false)
                continue
            }
            val buffer = c.getInputBuffer(index) ?: continue
            buffer.clear()
            val take = min(count - offset, buffer.remaining() / 2)
            for (i in 0 until take) {
                val s = pcm[offset + i].toInt()
                buffer.put((s and 0xFF).toByte())
                buffer.put((s shr 8 and 0xFF).toByte())
            }
            val pts = (samples + offset) * 1_000_000L / SAMPLE_RATE
            c.queueInputBuffer(index, 0, take * 2, pts, 0)
            offset += take
        }
        drain(info, false)
    }

    private fun finishEncoding(info: MediaCodec.BufferInfo) {
        val c = codec ?: return
        val index = c.dequeueInputBuffer(100_000)
        if (index >= 0) {
            c.queueInputBuffer(index, 0, 0, samples * 1_000_000L / SAMPLE_RATE, MediaCodec.BUFFER_FLAG_END_OF_STREAM)
            drain(info, true)
        }
        output?.flush()
    }

    private fun drain(info: MediaCodec.BufferInfo, endOfStream: Boolean) {
        val c = codec ?: return
        val o = output ?: return
        var idle = 0
        while (true) {
            val index = c.dequeueOutputBuffer(info, if (endOfStream) 10_000 else 0)
            when {
                index == MediaCodec.INFO_TRY_AGAIN_LATER -> {
                    if (!endOfStream || ++idle > 50) return
                }
                index < 0 -> Unit // format changed: ADTS carries its own format.
                else -> {
                    val buffer = c.getOutputBuffer(index)
                    val config = info.flags and MediaCodec.BUFFER_FLAG_CODEC_CONFIG != 0
                    if (buffer != null && info.size > 0 && !config) {
                        val bytes = ByteArray(info.size)
                        buffer.position(info.offset)
                        buffer.get(bytes, 0, info.size)
                        o.write(Adts.header(info.size, SAMPLE_RATE, CHANNELS))
                        o.write(bytes)
                    }
                    c.releaseOutputBuffer(index, false)
                    if (info.flags and MediaCodec.BUFFER_FLAG_END_OF_STREAM != 0) return
                }
            }
        }
    }

    private fun release() {
        runCatching { playback?.stop() }
        runCatching { playback?.release() }
        playback = null
        runCatching { mic?.stop() }
        runCatching { mic?.release() }
        mic = null
        runCatching { codec?.stop() }
        runCatching { codec?.release() }
        codec = null
        runCatching { output?.close() }
        output = null
    }
}
