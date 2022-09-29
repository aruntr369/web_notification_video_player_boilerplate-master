import 'package:audio_service/audio_service.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

import '../../../app/app.locator.dart';
import '../../../services/api_service.dart';

T? ambiguate<T>(T? value) => value;

class HomeViewModel extends BaseViewModel {

  //late FlickManager flickManager;
  final apiService = locator<ApiService>();

  HomeViewModel(this.flickManager);
  // FlickTogglePlayAction flickTogglePlayAction =const FlickTogglePlayAction();

  FlickManager flickManager;
  init() async {
    setBusy(true);


    // flickManager = FlickManager(
    //   videoPlayerController: VideoPlayerController.network("https://mazwai.com/videvo_files/video/free/2015-11/small_watermarked/9th-may_preview.webm"),
    //
    // );

    // change(){
    //   if (flickManager.flickVideoManager?.isPlaying?? false) apiService.audioHandler.play();
    // }

    // apiService.audioHandler = await AudioService.init(
    //   builder: () => AudioPlayerHandler(flickManager),
    //   config: const AudioServiceConfig(
    //     androidNotificationChannelId: 'com.webcastle.boilerplate.channel.audio',
    //     androidNotificationChannelName: 'Audio playback',
    //     androidNotificationOngoing: true,
    //   ),
    // );
    setBusy(false);

  }

}

// class AudioPlayerHandler extends BaseAudioHandler {
//   final _player = AudioPlayer();
//   late FlickManager flickManager;
//
//
//   @override
//   AudioPlayerHandler() {
//     // Broadcast that we're loading, and what controls are available.
//     playbackState.add(playbackState.value.copyWith(
//       controls: [MediaControl.play],
//       processingState: AudioProcessingState.loading,
//     ));
//     // Connect to the URL
//     _player.setUrl("https://exampledomain.com/song.mp3").then((_) {
//       // Broadcast that we've finished loading
//       playbackState.add(playbackState.value.copyWith(
//         processingState: AudioProcessingState.ready,
//       );
//       });
//   }}}



class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final apiService = locator<ApiService>();

  // static final _item = MediaItem(
  //   id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
  //   album: "Science Friday",
  //   title: "A Salute To Head-Scratching Science",
  //   artist: "Science Friday and WNYC Studios",
  //   duration: const Duration(milliseconds: 5739820),
  //   artUri: Uri.parse(
  //       'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
  // );

  //final _player = AudioPlayer();
  FlickManager flickManager;





  /// Initialise our audio handler.
  AudioPlayerHandler(this.flickManager) {
    // playbackState.add(playbackState.value.copyWith(
    //   controls: [MediaControl.pause],
    //   processingState: AudioProcessingState.ready,
    // ));

    // flickManager = FlickManager(
    //   videoPlayerController:
    //   VideoPlayerController.network("https://github.com/GeekyAnts/flick-video-player-demo-videos/blob/master/demo/custom_orientation.mp4?raw=true"),
    // );

    // playbackState.add(playbackState.value.copyWith(
    //   processingState: AudioProcessingState.ready,
    // ));
    // So that our clients (the Flutter UI and the system notification) know
    // what state to display, here we set up our audio handler to broadcast all
    // playback state changes as they happen via playbackState...
    // _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    // // ... and also the current media item via mediaItem.
    // mediaItem.add(_item);

    // Load the player.
    //_player.setAudioSource(AudioSource.uri(Uri.parse(_item.id)));
  }

  // In this simple example, we handle only 4 actions: play, pause, seek and
  // stop. Any button press from the Flutter UI, notification, lock screen or
  // headset will be routed through to these 4 methods so that you can handle
  // your audio playback logic in one place.

  @override
  Future<void> play() async {
    playbackState.add(playbackState.value.copyWith(
      playing: true,
      controls: [MediaControl.pause],
      processingState: AudioProcessingState.ready,

    ));
    await flickManager.flickControlManager?.play();
  }

  @override
  Future<void> pause() async {
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      controls: [MediaControl.play],
    ));
    await flickManager.flickControlManager?.pause();
    //flickManager.flickVideoManager?.isPlaying;
  }
  @override
  Future<void> stop() async {
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      //controls: [MediaControl.stop],
      processingState: AudioProcessingState.idle,

    ));
    //await flickManager.flickControlManager?.play();
    //flickManager.flickVideoManager?.isPlaying;
  }





  /// Transform a just_audio event into an audio_service state.
  ///
  /// This method is used from the constructor. Every event received from the
  /// just_audio player will be transformed into an audio_service state so that
  /// it can be broadcast to audio_service clients.
  // PlaybackState _transformEvent(PlaybackEvent event) {
  //   return PlaybackState(
  //     controls: [
  //       MediaControl.rewind,
  //       if (flickManager.flickVideoManager?.isPlaying?? false) MediaControl.pause else MediaControl.play,
  //       MediaControl.stop,
  //       MediaControl.fastForward,
  //     ],
  //     systemActions: const {
  //       MediaAction.seek,
  //       MediaAction.seekForward,
  //       MediaAction.seekBackward,
  //     },
  //     androidCompactActionIndices: const [0, 1, 3],
  //     processingState:  {
  //       ProcessingState.idle: AudioProcessingState.idle,
  //       flickManager.flickVideoManager?.isBuffering : AudioProcessingState.loading,
  //       flickManager.flickVideoManager?.isBuffering: AudioProcessingState.buffering,
  //       flickManager.flickVideoManager?.isVideoInitialized: AudioProcessingState.ready,
  //       flickManager.flickVideoManager?.isVideoEnded: AudioProcessingState.completed,
  //     }[flickManager.flickVideoManager]!,
  //     playing: flickManager.flickVideoManager?.isPlaying?? false,
  //     // updatePosition: _player.position,
  //     // bufferedPosition: _player.bufferedPosition,
  //     // speed: _player.speed,
  //     queueIndex: event.currentIndex,
  //   );
  // }
}