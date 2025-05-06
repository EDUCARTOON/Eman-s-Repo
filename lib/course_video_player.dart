
import 'package:flutter/material.dart';
import 'package:flutter_application_3/StartCourses.dart';
import 'package:video_player/video_player.dart';

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
  bool isMuted = false;


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
    _controller.addListener(() {
      setState(() {}); // Refresh UI on change
    });
  }
  /// Toggles mute/unmute
  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
      _controller.setVolume(isMuted ? 0 : 1);
    });
  }

  /// Seeks to a specific position in the video
  void _seekToPosition(double value) {
    final Duration position = Duration(seconds: value.toInt());
    _controller.seekTo(position);
  }

  /// Formats video duration into mm:ss
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final String minutes = twoDigits(duration.inMinutes);
    final String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
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
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Video Player")),
      body: _controller.value.isInitialized
          ? SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_controller),
                ],
              ),
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
                        _formatDuration(_controller.value.position),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        _formatDuration(_controller.value.duration),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Slider(
                    min: 0,
                    max: _controller.value.duration.inSeconds.toDouble(),
                    value: _controller.value.position.inSeconds.toDouble(),
                    onChanged: _seekToPosition,
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
                  onPressed: _togglePlayPause,
                ),
                IconButton(
                  icon: Icon(
                    isMuted ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _toggleMute,
                ),
              ],
            ),
          ],
        ),
      )
          : const Center(child: CircularProgressIndicator()),

    );
  }
}