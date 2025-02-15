import 'package:flutter/material.dart';
import 'package:flutter_application_3/Categories.dart';

void main() {
  runApp(const Educartoon());
}

class Educartoon extends StatelessWidget {
  const Educartoon({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EducartoonSelectionScreen(),
    );
  }
}

class EducartoonSelectionScreen extends StatelessWidget {
  const EducartoonSelectionScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFF93AACF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Hi, Educartoon',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What Would you like to learn Today?\nSearch Below.',
                style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for..',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.tune),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              
              // زيادة حجم الصورة المتحركة
              Center(
                child: Image.asset(
                  'assets/img/Hello-Dribbble--unscreen.gif',
                  height: 200, // زيادة الارتفاع
                ),
              ),
              
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Categories()),
    );
  },
  child: const Text(
    'SEE ALL',
    style: TextStyle(color: Color.fromARGB(255, 26, 73, 112)),
  ),
),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryCard(title: 'Education'),
                  CategoryCard(title: 'Religion'),
                  CategoryCard(title: 'Behavior'),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Courses',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: const Text('SEE ALL')),
                ],
              ),
              const Row(
                children: [
                  CourseCard(title: 'Education', rating: 4.2, students: 7830),
                  SizedBox(width: 16),
                  CourseCard(title: 'Religion', rating: 4.2, students: 1234),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Top Mentor',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: const Text('SEE ALL')),
                ],
              ),
              const Row(
                children: [
                  MentorCard(),
                  SizedBox(width: 16),
                  MentorCard(),
                  SizedBox(width: 16),
                  MentorCard(),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book, color: Colors.black), label: 'MY COURSES'),
          BottomNavigationBarItem(icon: Icon(Icons.inbox, color: Colors.black), label: 'INDOX'),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black), label: 'PROFILE'),
        ],
        unselectedItemColor: Colors.black, // اللون للأزرار غير المحددة
        selectedItemColor: Colors.black, // اللون للأزرار المحددة
        showSelectedLabels: true, // إظهار النصوص المحددة
        showUnselectedLabels: true, // إظهار النصوص غير المحددة
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;

  const CategoryCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // إزالة الخلفية المستطيلة
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final double rating;
  final int students;

  const CourseCard({super.key, required this.title, required this.rating, required this.students});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(rating.toString()),
                const Spacer(),
                Text('$students Std'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MentorCard extends StatelessWidget {
  const MentorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text('name', style: TextStyle(fontSize: 14)),
        ),
      ),
    );
  }
}