/// What a scan of an ADTS (raw AAC) file found.
class AdtsInfo {
  const AdtsInfo({
    required this.frames,
    required this.sampleRate,
    required this.validBytes,
  });

  /// Whole frames, from the start up to the first damaged or cut one.
  final int frames;

  /// Of the first frame; 0 when there is none.
  final int sampleRate;

  /// Bytes covered by [frames].
  final int validBytes;

  /// AAC carries 1024 samples per frame.
  Duration get duration => sampleRate == 0
      ? Duration.zero
      : Duration(microseconds: frames * 1024 * 1000000 ~/ sampleRate);
}

/// Counts ADTS frames in bytes fed piece by piece, so a long recording is
/// never read into memory at once. A file cut off by a killed process
/// ends in a partial frame, which is not counted.
class AdtsScanner {
  static const _rates = [
    96000, 88200, 64000, 48000, 44100, 32000, 24000, 22050, 16000, 12000, //
    11025, 8000, 7350,
  ];

  List<int> _carry = const [];
  int _frames = 0;
  int _sampleRate = 0;
  int _validBytes = 0;
  bool _stopped = false;

  void add(List<int> chunk) {
    if (_stopped) return;
    final data = _carry.isEmpty ? chunk : [..._carry, ...chunk];
    var pos = 0;
    while (pos + 7 <= data.length) {
      final b1 = data[pos + 1];
      if (data[pos] != 0xFF || (b1 & 0xF0) != 0xF0) {
        _stopped = true;
        break;
      }
      final b2 = data[pos + 2];
      final sfi = (b2 >> 2) & 0xF;
      final length =
          ((data[pos + 3] & 3) << 11) |
          (data[pos + 4] << 3) |
          (data[pos + 5] >> 5);
      final header = (b1 & 1) == 1 ? 7 : 9;
      if (sfi >= _rates.length || length <= header) {
        _stopped = true;
        break;
      }
      if (pos + length > data.length) break;
      final rate = _rates[sfi];
      if (_sampleRate == 0) {
        _sampleRate = rate;
      } else if (rate != _sampleRate) {
        _stopped = true;
        break;
      }
      _frames++;
      _validBytes += length;
      pos += length;
    }
    _carry = _stopped ? const [] : data.sublist(pos);
  }

  AdtsInfo get result => AdtsInfo(
    frames: _frames,
    sampleRate: _sampleRate,
    validBytes: _validBytes,
  );
}
