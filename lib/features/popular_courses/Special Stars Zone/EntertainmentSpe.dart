
  import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EntertainmentSpe extends StatelessWidget {
  const EntertainmentSpe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9BB0CC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Courses',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search box
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for ...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.search),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Sections
            Expanded(
              child: ListView(
                children: const [
                  CourseSection(title: 'Entertainment'),
                  SizedBox(height: 20),
                  CourseSection(title: 'Entertainment'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseSection extends StatelessWidget {
  final String title;

  const CourseSection({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Text('25 Mins', style: TextStyle(color: Colors.blue, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 10),
          const LessonTile(index: 1, title: 'name', duration: '15 Mins'),
          const SizedBox(height: 8),
          const LessonTile(index: 2, title: 'name', duration: '10 Mins'),
          const SizedBox(height: 8),
          const LessonTile(index: 3, title: 'Quiz', duration: ''),
        ],
      ),
    );
  }
}

class LessonTile extends StatelessWidget {
  final int index;
  final String title;
  final String duration;

  const LessonTile({
    required this.index,
    required this.title,
    required this.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: CircleAvatar(
            radius: 20, // تكبير حجم الدائرة
            backgroundColor: const Color(0xFFEAF2FB),
            child: Text(
              index.toString().padLeft(2, '0'),
              style: const TextStyle(fontSize: 16), // تكبير حجم النص داخل الدائرة
            ),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          subtitle: duration.isNotEmpty ? Text(duration, style: const TextStyle(fontSize: 14)) : null,
          trailing: SizedBox(
            width: 48, // تحديد عرض ثابت للزر
            height: 48, // تحديد ارتفاع ثابت للزر
            child: (index != 3)
                ? IconButton(
                    icon: const Icon(Icons.play_circle_fill, color: Colors.blue, size: 30), // تكبير حجم الأيقونة
                    onPressed: () {
                      context.push('/course-detail'); // navigate to course detail
                    },
                  )
                : IconButton(
                      icon: const Icon(Icons.play_circle_fill, color: Colors.blue, size: 30), // تكبير حجم الأيقونة
                    onPressed: () {
                      context.push('/course-detail'); // navigate to course detail
                    },
                  ),
          ),
        ),
      ],
    );
  }
}