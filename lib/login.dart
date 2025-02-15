import 'package:flutter/material.dart';
import 'package:flutter_application_3/ForgotPassword.dart';
import 'package:flutter_application_3/resgister.dart';
import 'package:flutter_application_3/signup1.dart';
import 'package:flutter_application_3/sigunp1.dart';
import 'package:flutter_application_3/profile1.dart'; // تأكد من استيراد الصفحة المطلوبة

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF93AACF), // لون الخلفية
    body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
              // إضافة الشعار (اللوجو)
              Image.asset(
                'assets/img/Untitled_design__3_-removebg-preview.png', // مسار اللوجو (استبدل بمسار اللوجو الفعلي)
                width: 800,
                height: 100,
              ),
              const SizedBox(height: 10), // مسافة بين الشعار والنص
              const Text(
                'Let’s Sign In.!                                             ',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 0), // مسافة بين النص
              const Text(
                'Login to Your Account to Continue your Courses',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(133, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 40),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (value) {}),
                      const Text('Remember Me'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgotPassword()), // تغيير هنا
                  );
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // الانتقال إلى صفحة Profile1 عند الضغط على زر "تسجيل الدخول"
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile1()), // تغيير هنا
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 5),
                  backgroundColor: const Color.fromARGB(255, 253, 254, 255), // لون الزر
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Sign In', style: TextStyle(color: Colors.black)),
                    SizedBox(width:10), // مسافة بين النص والسهم
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Or Continue With'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.apple),
                    onPressed: () {
                      // هنا يمكنك إضافة الإجراء المطلوب عند الضغط على زر "Apple"
                    },
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.facebook),
                    onPressed: () {
                      // هنا يمكنك إضافة الإجراء المطلوب عند الضغط على زر "Facebook"
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // الانتقال إلى صفحة تسجيل الدخول عند الضغط
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Resgister()),
                  );
                },
                child: const Text(
                  "Don't have an Account? SIGN Up",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
