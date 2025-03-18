
import 'package:flutter/material.dart';
import 'package:flutter_application_3/StartCourses.dart';
import 'package:video_player/video_player.dart';

// class CourseVideoPlayerScreen extends StatefulWidget {
//   final String videoUrl;

//   const CourseVideoPlayerScreen({super.key, required this.videoUrl});

//   @override
//   State<CourseVideoPlayerScreen> createState() =>
//       _CourseVideoPlayerScreenState();
// }

// class _CourseVideoPlayerScreenState extends State<CourseVideoPlayerScreen> {
//   late VideoPlayerController _controller;
//   bool isPlaying = true;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
//       ..initialize().then((_) {
//         setState(() {}); // Update UI when initialized
//       })
//       ..setLooping(true)
//       ..play(); // Auto-play video
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(),
//       body: _controller.value.isInitialized
//           ? Column(
//               children: [
//                 Stack(
//                   children: [
//                     Center(
//                         child: AspectRatio(
//                       aspectRatio: _controller.value.aspectRatio,
//                       child: VideoPlayer(_controller),
//                     )),
//                     // Play/Pause Button at the Bottom Center
//                     // Positioned(
//                     //   bottom: 50,
//                     //   left: 0,
//                     //   right: 0,
//                     //   child: Center(
//                     //     child: FloatingActionButton(
//                     //       backgroundColor: Colors.black54,
//                     //       onPressed: () {
//                     //         setState(() {
//                     //           isPlaying = !isPlaying;
//                     //           isPlaying ? _controller.play() : _controller.pause();
//                     //         });
//                     //       },
//                     //       child: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
//                     //           color: Colors.white),
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ],
//             )
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }

class CourseVideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const CourseVideoPlayerScreen({super.key, required this.videoUrl});

  @override
  State<CourseVideoPlayerScreen> createState() =>
      _CourseVideoPlayerScreenState();
}

class _CourseVideoPlayerScreenState extends State<CourseVideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    String directLink = _convertGoogleDriveLink(widget.videoUrl);
    _controller = VideoPlayerController.networkUrl(Uri.parse(directLink))
      ..initialize().then((_) {
        setState(() {}); // Update UI when initialized
        _controller.play();
      })
      ..setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Converts a standard Google Drive file link to a direct download link
  String _convertGoogleDriveLink(String url) {
    if (url.contains("drive.google.com")) {
      RegExp regExp = RegExp(r"/d/([^/]+)/");
      Match? match = regExp.firstMatch(url);
      if (match != null) {
        return "https://drive.google.com/uc?export=download&id=${match.group(1)}";
      }
    }
    return url; // Return original if not a Google Drive link
  }

  /// Toggles play/pause
  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        isPlaying = false;
      } else {
        _controller.play();
        isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: _controller.value.isInitialized
          ? Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    Positioned(
                      // top: 10, // Positioning it at the top-center like YouTube
                      child: GestureDetector(
                        onTap: _togglePlayPause,
                        child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          radius: 25,
                          child: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const CourseItem(index: '02', title: 'name', duration: '10 Mins'),
                const CourseItem(index: '03', title: 'Quiz', duration: ''),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}


