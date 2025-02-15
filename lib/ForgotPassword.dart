import 'package:flutter/material.dart';
import 'package:flutter_application_3/Verification.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF93AACF), // لون الخلفية
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.black, fontSize: 20), // حجم الخط في العنوان
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 150, // زيادة حجم الصورة
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Image(
                  image: AssetImage('assets/img/3d_animal_holding_a_book_back_to_school_concept___Premium_AI-generated_PSD-removebg-preview 1.png'), // تأكد من إضافة الصورة في مجلد assets
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select which contact details should we use to Reset Your Password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18), // زيادة حجم الخط
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // تغير موضع الظل
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.email, color: Colors.black),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Via Email\npriscilla.frank26@gmail.com',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Verification()),
                  );
                  // هنا يمكنك إضافة الإجراء المطلوب عند الضغط على زر "Continue"
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.white, // تغيير لون الزر إلى الأبيض
                  side: const BorderSide(color: Color(0xFF6200EE)), // إضافة حدود ملونة
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Color(0xFF6200EE), fontSize: 16), // تغيير لون النص إلى اللون المحدد
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}