import 'package:animeo/controllers/video_player_controller.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen>
    with WidgetsBindingObserver {
  BetterPlayerController? _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late var videoPlayerController;
  var episodeID = Get.arguments;

  // videoPlayerController.fetchStreamingLink(episodeID[0]['episodeID']);

  @override
  void initState() {
    super.initState();

    // videoPlayerController = Get.put(VideoPlayerController());

    videoPlayerController = Get.find<VideoPlayerController>();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    WidgetsBinding.instance.addObserver(this);
  }

  final indicator = const SpinKitChasingDots(
    color: Color(0xFF4098D7),
    size: 28,
  );

  void mediaPlayerControllerSetUp() {
    _controller = BetterPlayerController(
      BetterPlayerConfiguration(
        autoDetectFullscreenAspectRatio: true,
        fit: BoxFit.fitHeight,
        aspectRatio: 16 / 9,
        handleLifecycle: false,
        autoDetectFullscreenDeviceOrientation: true,
        autoPlay: true,
        allowedScreenSleep: false,
        autoDispose: true,
        fullScreenAspectRatio: 16 / 9,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          overflowModalColor: Colors.black87,
          overflowMenuIconsColor: Colors.white,
          overflowModalTextColor: Colors.white,
          playIcon: Icons.play_arrow,
          pauseIcon: Icons.pause_outlined,
          playerTheme: BetterPlayerTheme.cupertino,
          controlBarColor: Color(0xFF0D1321).withOpacity(.75),
          loadingWidget: indicator,
          progressBarPlayedColor: Color(0xFF4098D7),
          progressBarBufferedColor: Colors.grey,
          progressBarBackgroundColor: Color(0xFF323435),
          progressBarHandleColor: Color(0xFF4098D7),
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        videoPlayerController.animeStreamingLink!.value.sources[1].url
            .toString(),
        bufferingConfiguration: const BetterPlayerBufferingConfiguration(
          minBufferMs: 60000,
          maxBufferMs: 555000,
        ),
        // resolutions: Get.arguments['resolutions'],
        cacheConfiguration: const BetterPlayerCacheConfiguration(
          useCache: true,
          preCacheSize: 400000,
          maxCacheSize: 400000,
          maxCacheFileSize: 400000,
        ),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (X11; Fedora; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36',
          // 'Origin': origin,
          'Referer':
              videoPlayerController.animeStreamingLink!.value.headers.referer,
        },
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        _controller!.setControlsAlwaysVisible(true);
        break;
      case AppLifecycleState.inactive:
        _controller!.pause();
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<VideoPlayerController>();
    WidgetsBinding.instance.removeObserver(this);
    _controller!.clearCache();
    _controller!.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // videoPlayerController.fetchStreamingLink(episodeID[0]['episodeID']);
    return Obx(() {
      if (videoPlayerController.showLoading.value) {
        return const SafeArea(
          child: Scaffold(
            body: Center(
              child: SpinKitSpinningLines(color: Color(0xFF4098D7)),
            ),
          ),
        );
      } else {
        // videoPlayerController.showLoading.value = false;
        mediaPlayerControllerSetUp();
        return Scaffold(
          key: _formKey,
          appBar: AppBar(
            title: Text(
              'Episode ${episodeID[0]['episodeNum'].toString()}',
              style: GoogleFonts.urbanist()
                  .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            elevation: 0,
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.black,
          body: BetterPlayer(
            controller: _controller!,
          ),
        );
      }
    });
  }
}
