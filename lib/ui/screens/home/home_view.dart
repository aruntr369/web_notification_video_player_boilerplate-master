import 'package:audio_service/audio_service.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';


import '../../../app/app.locator.dart';
import '../../../services/api_service.dart';
import '../../tools/model_future_builder.dart';
import 'controls.dart';
import 'home_viewmodel.dart';

class HomeView extends StatefulWidget  {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  FlickManager
  flickManager = FlickManager(
  videoPlayerController: VideoPlayerController.network("https://mazwai.com/videvo_files/video/free/2015-11/small_watermarked/9th-may_preview.webm"),

  );
  final apiService = locator<ApiService>();


  @override
  Widget build(BuildContext context) {
    // FlickControlManager controlManager =
    // Provider.of<FlickControlManager>(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, viewModel, child) => Scaffold(
        body: SizedBox.expand(
          child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    child: FlickVideoPlayer(
                      flickManager: viewModel.flickManager,
                      // flickVideoWithControls: FlickVideoWithControls(
                      //   controls: CustomOrientationControls(audioHandler: viewModel.apiService.audioHandler),
                      // ),
                      // flickVideoWithControlsFullscreen: FlickVideoWithControls(
                      //   videoFit: BoxFit.fitWidth,
                      //   controls: CustomOrientationControls(audioHandler: viewModel.apiService.audioHandler),
                      // ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => viewModel.apiService.audioHandler.play,
                      child: Text("play")),
                  ElevatedButton(
                      onPressed: () => viewModel.apiService.audioHandler.pause,
                      child: Text("pause"))
                ],
              )

        ),
      ),
      viewModelBuilder: () => HomeViewModel(flickManager),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      debugPrint("AppLifecycleState1 paused");
      apiService.audioHandler = await AudioService.init(
        builder: () => AudioPlayerHandler(flickManager),
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.webcastle.boilerplate.channel.audio',
          androidNotificationChannelName: 'Audio playback',
          androidNotificationOngoing: true,
        ),
      );
      apiService.audioHandler.play();
    }
    if (state == AppLifecycleState.detached) {
      debugPrint("AppLifecycleState1 detached");
    }
    if (state == AppLifecycleState.inactive) {
      debugPrint("AppLifecycleState1 inactive");
    }
    if (state == AppLifecycleState.resumed) {
      debugPrint("AppLifecycleState1 resumed");
      apiService.audioHandler.stop();
    }
  }
  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
  }
}
