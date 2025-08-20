import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasawaaq/app_assets/app_assets.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:video_player/video_player.dart';

class InitialVideoPlayerWidget extends StatefulWidget {
  const InitialVideoPlayerWidget({Key? key}) : super(key: key);

  @override
  State<InitialVideoPlayerWidget> createState() =>
      _InitialVideoPlayerWidgetState();
}

class _InitialVideoPlayerWidgetState extends State<InitialVideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(AppAssets.initialVideo)
      // ..setLooping(true)
      ..initialize().then((_) {
        _controller.play();

        Future.delayed(const Duration(seconds: 4), () {
          locator<NavigationService>()
              .pushReplacementNamedTo(AppRouts.ADS_PAGE);
          // AppStartPage
        });
        // _controller.
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Color(0xFF014676),
            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: InkWell(
            // onTap: (){
            //   setState(() {
            //     _controller.value.isPlaying
            //         ? _controller.pause()
            //         : _controller.play();
            //   });
            // },
            child: Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: VideoPlayer(_controller)),
                    )
                  : Container(),
            ),
          ),
        ),
      ),
    );
  }
}
