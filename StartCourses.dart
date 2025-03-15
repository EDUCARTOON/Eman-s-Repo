// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_3/popular.dart';

void main() {
  runApp(const StartCoursesPage());
}

class StartCoursesApp extends StatelessWidget {
  const StartCoursesApp({super.key, required Course course});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartCoursesPage(),
    );
  }
}

class StartCoursesPage extends StatelessWidget {
  const StartCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB0C4DE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Start Courses',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
          Expanded(
            child: ListView(
              children: const [
                CourseSection(sectionTitle: 'Section 01 - Education', duration: '25 Mins'),
                CourseSection(sectionTitle: 'Section 02 - Education', duration: '25 Mins'),
              ],
            ),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PlaceholderPage()),
          );
        },
        child: const Icon(Icons.play_arrow, color: Colors.white),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Page")),
      body: const Center(child: Text("Content of new page")),
    );
  }
}
