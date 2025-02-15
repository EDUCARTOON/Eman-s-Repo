import 'package:flutter/material.dart';
import 'package:flutter_application_3/FavoriteTopics.dart';

class ProfileKids extends StatefulWidget {
  const ProfileKids({super.key});

  @override
  _ProfileKidsState createState() => _ProfileKidsState();
}

class _ProfileKidsState extends State<ProfileKids> {
  String? selectedPicture;
  DateTime? selectedDate;

  // قائمة الصور
  final List<String> images = [
    'assets/img/v (3).jpg',
    'assets/img/v (4).jpg',
    'assets/img/v (6).jpg',
    'assets/img/v (7).jpg',
    'assets/img/v__10_-removebg-preview.png',
    'assets/img/v__9_-removebg-preview.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF93AACF),
      appBar: AppBar(
        title: const Text('Profile kids'),
        backgroundColor: const Color(0xFF93AACF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage:
                    selectedPicture != null ? AssetImage(selectedPicture!) : null,
                child: selectedPicture == null
                    ? const Icon(Icons.person, size: 50, color: Colors.grey)
                    : null,
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  setState(() {
                    selectedDate = pickedDate;
                  });
                                },
                decoration: InputDecoration(
                  labelText: selectedDate != null
                      ? 'Date of Birth: ${selectedDate!.toLocal()}'.split(' ')[0]
                      : 'Date of Birth',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 30),
              const Text('Choose your account picture:'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: List.generate(images.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPicture = images[index]; // تحديث الصورة المختارة
                      });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(images[index]),
                      child: selectedPicture == images[index]
                          ? const Icon(Icons.check, color: Colors.black)
                          : null,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoriteTopicsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}