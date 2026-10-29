/// ADTS frames for tests: same header layout as the app's Kotlin writer
/// (`Adts.header`), AAC-LC, no CRC.
List<int> adtsFrame({
  int payload = 20,
  int sampleRateIndex = 8, // 16 kHz
  int channels = 1,
}) {
  final length = payload + 7;
  return [
    0xFF,
    0xF1,
    (1 << 6) | (sampleRateIndex << 2) | (channels >> 2),
    ((channels & 3) << 6) | (length >> 11),
    (length >> 3) & 0xFF,
    ((length & 7) << 5) | 0x1F,
    0xFC,
    ...List<int>.filled(payload, 0x11),
  ];
}

List<int> adtsFrames(int count, {int payload = 20}) => [
  for (var i = 0; i < count; i++) ...adtsFrame(payload: payload),
];
