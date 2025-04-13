import 'package:flutter/material.dart';
import 'package:flutter_application_3/features/courses/presentation/pages/course_video_player.dart';
import 'package:flutter_application_3/features/courses/presentation/pages/web_view.dart';

import 'features/popular_courses/presentation/pages/popular.dart';


// void main() {
//   runApp(const StartCoursesPage());
// }

class StartCoursesApp extends StatelessWidget {
  const StartCoursesApp({super.key, required this.course});
final Course course;
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartCoursesPage(course: course,),
    );
  }
}

class StartCoursesPage extends StatelessWidget {
  const StartCoursesPage({super.key, required this.course});
final Course course;
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Popular(
                  courseTitle: "Default Title", // حط عنوان مناسب هنا
                  course: null, // أو حط كائن حقيقي لو متوفر
                ),
              ),
            );
          },
        ),
        title: const Text(
          'Start Courses',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView( // التمرير لعرض الصفحة بالكامل
        child: Column(
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
            // تقليل المسافة بين العناصر
             CourseSection(sectionTitle: course.title, duration: '25 Mins'),
             CourseSection(sectionTitle: course.title, duration: '25 Mins'),
          ],
        ),
      ),
    );
  }
}

class CourseSection extends StatelessWidget {
  final String sectionTitle;
  final String duration;

  const CourseSection({super.key, required this.sectionTitle, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0), // تقليل المسافة بين الأقسام
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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(duration, style: const TextStyle(color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 8),
              const CourseItem(index: '01', title: 'name', duration: '15 Mins'),
              const CourseItem(index: '02', title: 'name', duration: '10 Mins'),
              const CourseItem(index: '03', title: 'Quiz', duration: ''),
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

  const CourseItem({super.key, required this.index, required this.title, required this.duration});

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
          if(index == '03'){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WebViewScreen(url:
              "https://docs.google.com/forms/d/e/1FAIpQLSdD16HS-jyucqvOFA8CS3NP2Qnztal6Ed_DUFP6iTiI5FlW-w/viewform?usp=dialog",)),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CourseVideoPlayerScreen(videoUrl:
            // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
            //"https://drive.google.com/file/d/1UAZPaYY5h0maiSQScKDh5Awci1eAxikk/view"
              "https://youtu.be/CiI5AexYO2E?si=ZyTFJFBwO4pPdqEf"
            ,)),
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
      body: WebViewScreenBody(url: url,),
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
      body: CourseVideoPlayerScreenBody(videoUrl: videoUrl,),
    );
  }
}
