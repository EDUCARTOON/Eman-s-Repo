import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/course_video_player.dart';
import 'package:flutter_application_3/web_view.dart';
import 'package:go_router/go_router.dart';

import 'ContinueCourse.dart';
import 'Quiz3-5edu/AskingAboutName.dart';
import 'core/widgets/quiz_not_found.dart';
import 'features/popular_courses/data/models/course_model.dart';
import 'features/popular_courses/presentation/pages/DownSyndrome.dart';
import 'features/popular_courses/presentation/pages/popular.dart';

// void main() {
//   runApp(const StartCoursesPage());
// }

class StartCoursesApp extends StatelessWidget {
  const StartCoursesApp(
      {super.key,  this.course, required this.courseModel,this.courseItem});
  final CourseItem? courseItem;
  final Course? course;
  final CourseModel? courseModel;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartCoursesPage(
        course: course,
        courseModel: courseModel,
        courseItem: courseItem,
      ),
    );
  }
}

class StartCoursesPage extends StatelessWidget {
  final CourseModel? courseModel;
  const StartCoursesPage(
      {super.key,  this.course, required this.courseModel,this.courseItem});
  final Course? course;
  final CourseItem? courseItem;
  String getFullTime(CourseModel course, int index) {
    if (course.videoUrl1[index].part2.isEmpty) {
      return getTime(course.videoUrl1[index].time);
    } else {
      // int totalTime= 0;
      // for(int i = 0;i<course.videoUrl1[index].part2.length;i++){
      //   totalTime +=  course.videoUrl1[index].part2[i].time;
      // }
      int totalTime = course.videoUrl1[index].time +
          course.videoUrl1[index].part2.fold(0, (sum, part) => sum + part.time);

      return getTime(
          totalTime);
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Popular(

                ),
              ),
            );
            //context.pushReplacement(Routes.popularCoursesScreen);
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
                              sectionTitle:course!=null? course?.title??"":courseItem?.title??"",
                              duration: getFullTime(courseModel!, index),
                              courseModel: courseModel!,
                              courseId: index, course: course,courseItem: courseItem,
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
final Course? course;
  final CourseItem? courseItem;
  const CourseSection(
      {super.key,
        this.courseItem,
      required this.sectionTitle,
      required this.duration,
      required this.courseModel,
      required this.courseId,  this.course});

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
              const SizedBox(height: 10),
              CourseItems(
                index: '01',
                title: courseModel.videoUrl1[courseId].name,
                duration: getTime(courseModel.videoUrl1[courseId].time),
                courseModel: courseModel,
                courseId: courseId, course: course,courseItem: courseItem,
              ),
              const SizedBox(height: 20),
              if (courseModel.videoUrl1[courseId].part2.isNotEmpty)
                ...List.generate(
                  courseModel.videoUrl1[courseId].part2.length,
                      (partIndex) => CourseItems(
                    index: '0${partIndex + 2}', // dynamic label
                    title: courseModel.videoUrl1[courseId].part2[partIndex].name,
                    duration: getTime(courseModel.videoUrl1[courseId].part2[partIndex].time),
                    courseModel: courseModel,
                    courseId: courseId,
                    partId: partIndex, // new!
                    course: course,
                        courseItem: courseItem,
                  ),
                ),


              const SizedBox(height: 20),
              CourseItems(
                index:courseModel.videoUrl1[courseId].part2.isEmpty?'02':'0${courseModel.videoUrl1[courseId].part2.length+2}',
                title: 'Quiz',
                duration: '',
                courseModel: courseModel,
                courseId: courseId,course: course,
                courseItem: courseItem,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseItems extends StatelessWidget {
  final String index;
  final String title;
  final String duration;
  final CourseModel courseModel;
  final int courseId;
  final Course? course;
  final int? partId;
  final CourseItem? courseItem;
  const CourseItems(
      {super.key,
        this.courseItem,
      required this.index,
      required this.title,
      required this.duration,
      required this.courseModel,
      required this.courseId,  this.course,  this.partId,});
  String convertGoogleDriveUrl(String url) {
    final regex = RegExp(r'd/([a-zA-Z0-9_-]+)');
    final match = regex.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      final fileId = match.group(1);
      return 'https://drive.google.com/uc?export=view&id=$fileId';
    } else {
      return "";
    }
  }
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
      trailing:
    Stack(
    alignment: Alignment.center,
      children: [
        // Thumbnail image with caching
        courseModel.videoUrl1[courseId].part2.isEmpty? index=='02'?CircleAvatar(
         backgroundColor: Colors.blue[100],
       ): ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl:  convertGoogleDriveUrl(courseModel.videoUrl1[courseId].thumbnail), // Replace with actual thumbnail URL
            width: 65,
            height: 60,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ):index=='0${courseModel.videoUrl1[courseId].part2.length+2}'?CircleAvatar(backgroundColor: Colors.blue[100],):

        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl:  convertGoogleDriveUrl(index == '01'
                ? courseModel.videoUrl1[courseId].thumbnail
                : courseModel.videoUrl1[courseId].part2[partId??0].thumbnail,), // Replace with actual thumbnail URL
            width: 65,
            height: 60,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        // Circular play button
        IconButton(
          onPressed: () {
            if(courseModel.videoUrl1[courseId].part2.isEmpty){
            if (index == '02') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    if (course != null){
                      return course!.quiz.isEmpty || courseId >= course!.quiz.length?QuizNotFound(): course!.quiz[courseId];
                    }
                    return courseItem!.quiz.isEmpty || courseId >= courseItem!.quiz.length?QuizNotFound(): courseItem!.quiz[courseId];   //courseItem?.quiz[courseId]!=null?courseItem!.quiz.isEmpty || courseId >= courseItem!.quiz.length?QuizNotFound():courseItem!.quiz[courseId]:QuizNotFound();
                  },
                ),
              );

            }else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseVideoPlayerScreen(
                    videoUrl:
                         courseModel.videoUrl1[courseId].url
                  ),
                ),
              );
            }
            return;
            }

              if(index=='0${courseModel.videoUrl1[courseId].part2.length+2}'){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      if (course != null){
                        return course!.quiz.isEmpty || courseId >= course!.quiz.length?QuizNotFound(): course!.quiz[courseId];
                      }
                      return courseItem!.quiz.isEmpty || courseId >= courseItem!.quiz.length?QuizNotFound(): courseItem!.quiz[courseId];   //courseItem?.quiz[courseId]!=null?courseItem!.quiz.isEmpty || courseId >= courseItem!.quiz.length?QuizNotFound():courseItem!.quiz[courseId]:QuizNotFound();
                    },
                  ),
                );
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseVideoPlayerScreen(
                      videoUrl: index == '01'
                          ? courseModel.videoUrl1[courseId].url
                          : courseModel.videoUrl1[courseId].part2[partId??0].url,
                    ),
                  ),
                );
              }

          },
          icon: const Icon(Icons.play_arrow, color: Colors.black, size: 32),
         // child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
        ),
      ],
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
String getTime(int time) {
  final minutes = time ~/ 60;
  final seconds = time % 60;
  String result = '';
  if (minutes > 0) result += '${minutes}m ';
  if (seconds > 0 || minutes == 0) result += '${seconds}s';
  return result.trim();
}
