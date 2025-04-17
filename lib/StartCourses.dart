import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/features/courses/data/models/course_model.dart';
import 'package:flutter_application_3/features/courses/presentation/pages/course_video_player.dart';
import 'package:flutter_application_3/features/courses/presentation/pages/web_view.dart';
import 'package:go_router/go_router.dart';

import 'features/popular_courses/data/models/course_model.dart';
import 'features/popular_courses/presentation/pages/popular.dart';

// void main() {
//   runApp(const StartCoursesPage());
// }

class StartCoursesApp extends StatelessWidget {
  const StartCoursesApp(
      {super.key, required this.course, required this.courseModel});
  final Course course;
  final CourseModel? courseModel;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartCoursesPage(
        course: course,
        courseModel: courseModel,
      ),
    );
  }
}

class StartCoursesPage extends StatelessWidget {
  final CourseModel? courseModel;
  const StartCoursesPage(
      {super.key, required this.course, required this.courseModel});
  final Course course;
  String getFullTime(CourseModel course, int index) {
    if (course.videoUrl2.isEmpty) {
      return getTime(course.videoUrl1[index].time);
    } else {
      return getTime(
          course.videoUrl1[index].time + course.videoUrl2[index].time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB0C4DE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const Popular(
            //        // أو حط كائن حقيقي لو متوفر
            //     ),
            //   ),
            // );
            context.pushReplacement(Routes.popularCoursesScreen);
          },
        ),
        title: const Text(
          'Start Courses',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: courseModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0), // تقليل المسافة هنا
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for ...',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                courseModel!.videoUrl1.isEmpty
                    ? const Center(
                        child: Text(
                          "No Courses Now ",
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: courseModel!.videoUrl1.length,
                          itemBuilder: (context, index) {
                            return CourseSection(
                              sectionTitle: course.title,
                              duration: getFullTime(courseModel!, index),
                              courseModel: courseModel!,
                              courseId: index,
                            );
                          },
                        ),
                      ),
                // تقليل المسافة بين العناصر
                //CourseSection(sectionTitle: course.title, duration: '25 Mins'),
                // CourseSection(sectionTitle: course.title, duration: '25 Mins'),
              ],
            ),
    );
  }
}

class CourseSection extends StatelessWidget {
  final String sectionTitle;
  final String duration;
  final CourseModel courseModel;
  final int courseId;

  const CourseSection(
      {super.key,
      required this.sectionTitle,
      required this.duration,
      required this.courseModel,
      required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 10.0, vertical: 5.0), // تقليل المسافة بين الأقسام
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0), // تقليل المسافة داخل البطاقة
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sectionTitle,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(duration, style: const TextStyle(color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 8),
              CourseItem(
                index: '01',
                title: courseModel.videoUrl1[courseId].name,
                duration: getTime(courseModel.videoUrl1[courseId].time),
                courseModel: courseModel,
                courseId: courseId,
              ),
              courseModel.videoUrl2.isEmpty
                  ? const SizedBox()
                  : CourseItem(
                      index: '02',
                      title: courseModel.videoUrl2[courseId].name,
                      duration: getTime(courseModel.videoUrl2[courseId].time),
                      courseModel: courseModel,
                      courseId: courseId,
                    ),
              CourseItem(
                index: '03',
                title: 'Quiz',
                duration: '',
                courseModel: courseModel,
                courseId: courseId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseItem extends StatelessWidget {
  final String index;
  final String title;
  final String duration;
  final CourseModel courseModel;
  final int courseId;
  const CourseItem(
      {super.key,
      required this.index,
      required this.title,
      required this.duration,
      required this.courseModel,
      required this.courseId});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(index, style: const TextStyle(color: Colors.black)),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: duration.isNotEmpty ? Text(duration) : null,
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
        ),
        onPressed: () {
          if (index == '03') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const WebViewScreen(
                        url:
                            "https://docs.google.com/forms/d/e/1FAIpQLSdD16HS-jyucqvOFA8CS3NP2Qnztal6Ed_DUFP6iTiI5FlW-w/viewform?usp=dialog",
                      )),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseVideoPlayerScreen(
                      videoUrl: index == '01'
                          ? courseModel.videoUrl1[courseId].url
                          : courseModel.videoUrl2[courseId].url,
                    )),
          );
        },
        child: const Icon(Icons.play_arrow, color: Colors.white),
      ),
    );
  }
}

class WebViewScreen extends StatelessWidget {
  final String url;
  const WebViewScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Web View")),
      body: WebViewScreenBody(
        url: url,
      ),
    );
  }
}

class CourseVideoPlayerScreen extends StatelessWidget {
  final String videoUrl;
  const CourseVideoPlayerScreen({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Course Video Player")),
      body: CourseVideoPlayerScreenBody(
        videoUrl: videoUrl,
      ),
    );
  }
}

String getTime(int time) {
  final minutes = time ~/ 60;
  final seconds = time % 60;
  String result = '';
  if (minutes > 0) result += '${minutes}m ';
  if (seconds > 0 || minutes == 0) result += '${seconds}s';
  return result.trim();
}
