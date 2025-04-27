// import 'package:flutter/material.dart';
//
// import 'features/popular_courses/presentation/pages/popular.dart';
// // استيراد Course من popular.dart
//  // تأكد من المسار المناسب بناءً على مكان ملف popular.dart
//
// void main() {
//   runApp(BehaviorCoursesApp(course: Course(title: 'Behavior Course', category: 'Behavior', rating: 4.0, students: 100, ageGroup: '5-8')));
// }
//
// class BehaviorCoursesApp extends StatelessWidget {
//   final Course course;
//
//   const BehaviorCoursesApp({super.key, required this.course});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BehaviorCoursesPage(course: course),
//     );
//   }
// }
//
// class BehaviorCoursesPage extends StatelessWidget {
//   final Course course;
//
//   const BehaviorCoursesPage({super.key, required this.course});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFB0C4DE),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//   icon: const Icon(Icons.arrow_back, color: Colors.black),
//   onPressed: () {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => Popular(courseTitle: course.title, course: null,),
//       ),
//     );
//   },
// ),
//
//         title: const Text(
//           'Behavior Courses',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: false,
//       ),
//       body: SingleChildScrollView( // استخدام التمرير
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0), // تقليل المسافة بين الحقول
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search for ...',
//                   filled: true,
//                   fillColor: Colors.white,
//                   prefixIcon: const Icon(Icons.search, color: Colors.black),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//             // تقليل المسافة بين الأقسام
//             const CourseSection(sectionTitle: 'Section 01 - Behavior', duration: '25 Mins'),
//             const CourseSection(sectionTitle: 'Section 02 - Behavior', duration: '25 Mins'),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CourseSection extends StatelessWidget {
//   final String sectionTitle;
//   final String duration;
//
//   const CourseSection({super.key, required this.sectionTitle, required this.duration});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0), // تقليل المسافة بين الأقسام
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0), // تقليل المسافة داخل البطاقة
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     sectionTitle,
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   Text(duration, style: const TextStyle(color: Colors.blue)),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               const CourseItem(index: '01', title: 'name', duration: '15 Mins'),
//               const CourseItem(index: '02', title: 'name', duration: '10 Mins'),
//               const CourseItem(index: '03', title: 'Quiz', duration: ''),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CourseItem extends StatelessWidget {
//   final String index;
//   final String title;
//   final String duration;
//
//   const CourseItem({super.key, required this.index, required this.title, required this.duration});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundColor: Colors.blue[100],
//         child: Text(index, style: const TextStyle(color: Colors.black)),
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(fontWeight: FontWeight.bold),
//       ),
//       subtitle: duration.isNotEmpty ? Text(duration) : null,
//       trailing: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue,
//           shape: const CircleBorder(),
//           padding: const EdgeInsets.all(10),
//         ),
//         onPressed: () {
//           // انتقل إلى صفحة جديدة عند الضغط على زر التشغيل
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CourseDetailPage(courseTitle: title),
//             ),
//           );
//         },
//         child: const Icon(Icons.play_arrow, color: Colors.white),
//       ),
//     );
//   }
// }
//
// class CourseDetailPage extends StatelessWidget {
//   final String courseTitle;
//
//   const CourseDetailPage({super.key, required this.courseTitle});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(courseTitle)),
//       body: const Center(child: Text("Content of the course")),
//     );
//   }
// }
