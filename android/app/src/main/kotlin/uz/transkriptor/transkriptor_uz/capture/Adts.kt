package uz.transkriptor.transkriptor_uz.capture

import android.media.MediaCodec
import android.media.MediaFormat
import android.media.MediaMuxer
import java.io.BufferedInputStream
import java.io.EOFException
import java.io.File
import java.io.FileInputStream
import java.io.IOException
import java.nio.ByteBuffer

/**
 * Recordings are written as raw AAC in ADTS frames first. Every frame
 * carries its own header, so a file cut off by a killed process is still
 * readable up to its last whole frame — an .m4a is not: MediaMuxer writes
 * the index (moov) only when it is stopped. [remux] turns ADTS into the
 * .m4a the backend accepts.
 */
object Adts {
    const val SAMPLES_PER_FRAME = 1024

    private val SAMPLE_RATES = intArrayOf(
        96000, 88200, 64000, 48000, 44100, 32000, 24000, 22050, 16000, 12000, 11025, 8000, 7350,
    )

    fun sampleRateIndex(rate: Int): Int {
        val i = SAMPLE_RATES.indexOf(rate)
        require(i >= 0) { "ADTS has no index for $rate Hz" }
        return i
    }

    /** The 7-byte header (no CRC) for one AAC-LC frame of [payloadSize] bytes. */
    fun header(payloadSize: Int, sampleRate: Int, channels: Int): ByteArray {
        val length = payloadSize + 7
        val profile = 1 // AAC-LC: audio object type 2, minus one.
        val sfi = sampleRateIndex(sampleRate)
        return byteArrayOf(
            0xFF.toByte(),
            0xF1.toByte(), // MPEG-4, layer 0, protection absent
            ((profile shl 6) or (sfi shl 2) or (channels shr 2)).toByte(),
            (((channels and 3) shl 6) or (length shr 11)).toByte(),
            ((length shr 3) and 0xFF).toByte(),
            (((length and 7) shl 5) or 0x1F).toByte(),
            0xFC.toByte(),
        )
    }

    private class FrameHeader(
        val headerSize: Int,
        val frameSize: Int,
        val objectType: Int,
        val sfi: Int,
        val channels: Int,
    )

    private fun parse(h: ByteArray): FrameHeader? {
        val b0 = h[0].toInt() and 0xFF
        val b1 = h[1].toInt() and 0xFF
        if (b0 != 0xFF || (b1 and 0xF0) != 0xF0) return null
        val b2 = h[2].toInt() and 0xFF
        val b3 = h[3].toInt() and 0xFF
        val b4 = h[4].toInt() and 0xFF
        val b5 = h[5].toInt() and 0xFF
        val headerSize = if (b1 and 1 == 1) 7 else 9
        val frameSize = ((b3 and 3) shl 11) or (b4 shl 3) or (b5 shr 5)
        val sfi = (b2 shr 2) and 0xF
        if (frameSize <= headerSize || sfi >= SAMPLE_RATES.size) return null
        return FrameHeader(
            headerSize = headerSize,
            frameSize = frameSize,
            objectType = (b2 shr 6) + 1,
            sfi = sfi,
            channels = ((b2 and 1) shl 2) or (b3 shr 6),
        )
    }

    /**
     * Writes [src] (ADTS) into [dst] (.m4a) and returns the duration in ms.
     * Stops at the first incomplete or damaged frame, which is how a
     * truncated file ends. Throws when there is not a single whole frame.
     */
    fun remux(src: File, dst: File): Long {
        val part = File(dst.path + ".part")
        part.delete()
        var muxer: MediaMuxer? = null
        var started = false
        var frames = 0L
        var sampleRate = 0
        try {
            BufferedInputStream(FileInputStream(src), 1 shl 16).use { input ->
                val head = ByteArray(9)
                var payload = ByteArray(8192)
                var buffer = ByteBuffer.allocateDirect(8192)
                val info = MediaCodec.BufferInfo()
                var track = -1
                while (true) {
                    if (!readFully(input, head, 0, 7)) break
                    val fh = parse(head) ?: break
                    if (fh.headerSize == 9 && !readFully(input, head, 7, 2)) break
                    val size = fh.frameSize - fh.headerSize
                    if (payload.size < size) {
                        payload = ByteArray(size)
                        buffer = ByteBuffer.allocateDirect(size)
                    }
                    if (!readFully(input, payload, 0, size)) break
                    if (muxer == null) {
                        sampleRate = SAMPLE_RATES[fh.sfi]
                        val format = MediaFormat.createAudioFormat(
                            MediaFormat.MIMETYPE_AUDIO_AAC, sampleRate, fh.channels,
                        )
                        // AudioSpecificConfig: object type, rate index, channels.
                        val csd = byteArrayOf(
                            ((fh.objectType shl 3) or (fh.sfi shr 1)).toByte(),
                            (((fh.sfi and 1) shl 7) or (fh.channels shl 3)).toByte(),
                        )
                        format.setByteBuffer("csd-0", ByteBuffer.wrap(csd))
                        muxer = MediaMuxer(part.path, MediaMuxer.OutputFormat.MUXER_OUTPUT_MPEG_4)
                        track = muxer.addTrack(format)
                        muxer.start()
                        started = true
                    } else if (SAMPLE_RATES[fh.sfi] != sampleRate) {
                        break
                    }
                    buffer.clear()
                    buffer.put(payload, 0, size)
                    buffer.flip()
                    info.set(
                        0,
                        size,
                        frames * SAMPLES_PER_FRAME * 1_000_000L / sampleRate,
                        MediaCodec.BUFFER_FLAG_KEY_FRAME,
                    )
                    muxer!!.writeSampleData(track, buffer, info)
                    frames++
                }
            }
            if (frames == 0L) throw IOException("no whole AAC frame in ${src.name}")
            muxer!!.stop()
            started = false
            muxer.release()
            muxer = null
            if (!part.renameTo(dst)) throw IOException("cannot rename to ${dst.name}")
            return frames * SAMPLES_PER_FRAME * 1000L / sampleRate
        } finally {
            if (started) runCatching { muxer?.stop() }
            runCatching { muxer?.release() }
            part.delete()
        }
    }

    /** False at a clean or a partial end of stream. */
    private fun readFully(input: BufferedInputStream, buf: ByteArray, off: Int, len: Int): Boolean {
        var read = 0
        while (read < len) {
            val n = try {
                input.read(buf, off + read, len - read)
            } catch (_: EOFException) {
                -1
            }
            if (n < 0) return false
            read += n
        }
        return true
    }
}
