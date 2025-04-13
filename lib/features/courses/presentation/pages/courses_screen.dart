// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_3/educartoon_screen.dart';


void main() {
  runApp(const CoursesScreenApp());
}

class CoursesScreenApp extends StatelessWidget {
  const CoursesScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CoursesScreen(),
    );
  }
}

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  bool isCompleted = true;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB0C4DE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // هنا يمكن أن تحدد الصفحة التي تريد الانتقال إليها بدلاً من الرجوع للخلف
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EducartoonScreen(courseTitle: '', course: null,), // استبدل بـاسم الصفحة التي تريد الانتقال إليها
              ),
            );
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Courses Screen',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search for ...',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search, color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isCompleted = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      backgroundColor: isCompleted ? Colors.green : Colors.grey[300],
                    ),
                    child: const Text("Completed", style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isCompleted = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      backgroundColor: isCompleted ? Colors.grey[300] : Colors.green,
                    ),
                    child: const Text("Ongoing", style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return CourseCard(isCompleted: isCompleted);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final bool isCompleted;
  const CourseCard({super.key, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            color: Colors.black,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Course Name", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const Text("Instructor Name", style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 2),
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 13),
                    SizedBox(width: 2),
                    Text("4.5", style: TextStyle(fontSize: 12)),
                    SizedBox(width: 6),
                    Text("2 Hrs 30 Mins", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                if (!isCompleted)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: LinearProgressIndicator(
                      value: 0.7,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                      minHeight: 5,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
