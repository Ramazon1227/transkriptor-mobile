import 'package:injectable/injectable.dart';
import 'package:transkriptor_uz/features/player/domain/playback_engine.dart';
import 'package:transkriptor_uz/features/player/infrastructure/engine/video_player_engine.dart';
import 'package:transkriptor_uz/features/player/infrastructure/engine/youtube_engine.dart';

@LazySingleton(as: PlaybackEngineFactory)
class PlatformEngineFactory implements PlaybackEngineFactory {
  @override
  PlaybackEngine create({bool youtube = false}) =>
      youtube ? YoutubeEngine() : VideoPlayerEngine();
}
