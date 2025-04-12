// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_application_3/StartCourses.dart';
// // import 'package:video_player/video_player.dart';
// //
// // // class CourseVideoPlayerScreen extends StatefulWidget {
// // //   final String videoUrl;
// //
// // //   const CourseVideoPlayerScreen({super.key, required this.videoUrl});
// //
// // //   @override
// // //   State<CourseVideoPlayerScreen> createState() =>
// // //       _CourseVideoPlayerScreenState();
// // // }
// //
// // // class _CourseVideoPlayerScreenState extends State<CourseVideoPlayerScreen> {
// // //   late VideoPlayerController _controller;
// // //   bool isPlaying = true;
// //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
// // //       ..initialize().then((_) {
// // //         setState(() {}); // Update UI when initialized
// // //       })
// // //       ..setLooping(true)
// // //       ..play(); // Auto-play video
// // //   }
// //
// // //   @override
// // //   void dispose() {
// // //     _controller.dispose();
// // //     super.dispose();
// // //   }
// //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       appBar: AppBar(),
// // //       body: _controller.value.isInitialized
// // //           ? Column(
// // //               children: [
// // //                 Stack(
// // //                   children: [
// // //                     Center(
// // //                         child: AspectRatio(
// // //                       aspectRatio: _controller.value.aspectRatio,
// // //                       child: VideoPlayer(_controller),
// // //                     )),
// // //                     // Play/Pause Button at the Bottom Center
// // //                     // Positioned(
// // //                     //   bottom: 50,
// // //                     //   left: 0,
// // //                     //   right: 0,
// // //                     //   child: Center(
// // //                     //     child: FloatingActionButton(
// // //                     //       backgroundColor: Colors.black54,
// // //                     //       onPressed: () {
// // //                     //         setState(() {
// // //                     //           isPlaying = !isPlaying;
// // //                     //           isPlaying ? _controller.play() : _controller.pause();
// // //                     //         });
// // //                     //       },
// // //                     //       child: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
// // //                     //           color: Colors.white),
// // //                     //     ),
// // //                     //   ),
// // //                     // ),
// // //                   ],
// // //                 ),
// // //               ],
// // //             )
// // //           : const Center(child: CircularProgressIndicator()),
// // //     );
// // //   }
// // // }
// //
// //




import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseVideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const CourseVideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<CourseVideoPlayerScreen> createState() => _CourseVideoPlayerScreenState();
}

class _CourseVideoPlayerScreenState extends State<CourseVideoPlayerScreen> {
  late VideoPlayerController _videoController;
  YoutubePlayerController? _youtubeController;

  bool isYoutube = false;
  bool isPlaying = true;
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    isYoutube = _isYouTubeUrl(widget.videoUrl);

    if (isYoutube) {
      final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          enableCaption: false,
          useHybridComposition: true,
        ),
      );
    } else {
      final directLink = _convertGoogleDriveLink(widget.videoUrl);
      _videoController = VideoPlayerController.networkUrl(Uri.parse(directLink))
        ..initialize().then((_) {
          setState(() {});
          _videoController.play();
        });
      _videoController.setLooping(true);
    }
  }

  @override
  void dispose() {
    if (!isYoutube) {
      _videoController.dispose();
    } else {
      _youtubeController?.dispose();
    }
    // Reset orientation and UI overlays after video is finished
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  bool _isYouTubeUrl(String url) {
    return url.contains('youtube.com') || url.contains('youtu.be');
  }

  String _convertGoogleDriveLink(String url) {
    if (url.contains("drive.google.com")) {
      RegExp regExp = RegExp(r"/d/([^/]+)/");
      Match? match = regExp.firstMatch(url);
      if (match != null) {
        return "https://drive.google.com/uc?export=download&id=${match.group(1)}";
      }
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return isYoutube
        ? YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubeController!,
        onReady: () {
          _youtubeController!.addListener(_youtubeListener);
        },
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        bottomActions: const [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
          PlaybackSpeedButton(),
          FullScreenButton(),
        ],
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(title: const Text("YouTube Player")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(aspectRatio: 16 / 9, child: player),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    )
        : Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Video Player")),
      body: _videoController.value.isInitialized
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_videoController.value.position),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      _formatDuration(_videoController.value.duration),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Slider(
                  min: 0,
                  max: _videoController.value.duration.inSeconds.toDouble(),
                  value: _videoController.value.position.inSeconds.toDouble(),
                  onChanged: (value) {
                    _videoController.seekTo(Duration(seconds: value.toInt()));
                  },
                  activeColor: Colors.red,
                  inactiveColor: Colors.white30,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    if (_videoController.value.isPlaying) {
                      _videoController.pause();
                      isPlaying = false;
                    } else {
                      _videoController.play();
                      isPlaying = true;
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    isMuted = !isMuted;
                    _videoController.setVolume(isMuted ? 0 : 1);
                  });
                },
              ),
            ],
          ),
        ],
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  void _youtubeListener() {
    if (_youtubeController!.value.isFullScreen) {
      _enterFullScreenMode();
    } else {
      _exitFullScreenMode();
    }
  }

  void _enterFullScreenMode() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Hide navigation bar and status bar
  }

  void _exitFullScreenMode() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // Show navigation bar again
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}



