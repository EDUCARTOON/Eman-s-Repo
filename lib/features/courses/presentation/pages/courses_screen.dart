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

class ChildCourse {
  final String courseName;
  final String instructorName;
  final double rating;
  final int time;
  final String img;

  ChildCourse({
    required this.courseName,
    required this.instructorName,
    required this.rating,
    required this.img,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'courseName': courseName,
      'instructorName': instructorName,
      'rating': rating,
      'time': time,
      'img': img,
    };
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
  List<ChildCourse> myCourses = [
    ChildCourse(
        courseName: "Stories of the Prophets series",
        instructorName: "Learn with your friend Simsim",
        rating: 4.5,
        img: "assets/img/Religion 3-5.jpeg.jpg",
        time: 30),
    ChildCourse(
        courseName: "Facts about the human body",
        instructorName: "Learn with your friend Amer",
        rating: 4.3,
        img: "assets/img/Education 3-5.jpeg.jpg",
        time: 40),
    ChildCourse(
        courseName: "Let's Draw Animals Together",
        instructorName: "Learn with your friend Lolo",
        rating: 4.1,
        img: "assets/img/Entertainment 3-5.jpeg.jpg",
        time: 25),
    ChildCourse(
        courseName: "Ancient Egyptian Civilization",
        instructorName: "Learn with your friend Nemo",
        rating: 4.6,
        img: "assets/img/civilivation 3-5.jpeg.jpg",
        time: 45),
    ChildCourse(
        courseName: "Introduction to the World of Computers",
        instructorName: "Learn with your friend Samir",
        rating: 4.0,
        img: "assets/img/Technology 3-5.jpeg.jpg",
        time: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB0C4DE),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 3,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Courses Screen',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      backgroundColor:
                          isCompleted ? Colors.green : Colors.grey[300],
                    ),
                    child: const Text("Completed",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isCompleted = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      backgroundColor:
                          isCompleted ? Colors.grey[300] : Colors.green,
                    ),
                    child: const Text("Ongoing",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return CourseCard(
                    isCompleted: isCompleted,
                    myCourse: myCourses[index],
                  );
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
  final ChildCourse myCourse;

  const CourseCard({
    super.key,
    required this.isCompleted,
    required this.myCourse,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 3), // Border for white box
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3), // Border for image
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                myCourse.img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  myCourse.courseName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  myCourse.instructorName,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      "${myCourse.rating}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${myCourse.time} Mins",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                if (!isCompleted)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: LinearProgressIndicator(
                      value: 0.7,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                      minHeight: 6,
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
