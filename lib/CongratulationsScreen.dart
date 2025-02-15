import 'package:flutter/material.dart';
import 'package:flutter_application_3/login.dart';
import 'dart:async';

import 'package:flutter_application_3/signup1.dart';

void main() {
  runApp(const CongratulationsScreen());
}

class Congratulationsscreen extends StatelessWidget {
  const Congratulationsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CongratulationsScreen(),
    );
  }
}

class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({super.key});

  @override
  _CongratulationsScreenState createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  void initState() {
    super.initState();
    // الانتقال بعد 5 ثواني إلى صفحة signup1
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF454866),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: const Color(0xFFEFEFEF),
            borderRadius: BorderRadius.circular(15.0),
          ),
          width: 300,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // استبدال أيقونة القفل بالصورة المخصصة
              Image.asset(
                'assets/img/Group 11.png', // مسار الصورة
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                "Congratulations",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your Account is Ready to Use. You will be redirected to the Home Page in a Few Seconds.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


