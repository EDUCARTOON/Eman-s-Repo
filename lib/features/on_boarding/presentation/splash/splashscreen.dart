import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/features/on_boarding/presentation/home.dart';
import 'package:go_router/go_router.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      log('Splashscreen');
      context.go(Routes.onBoarding);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //   return const Home();
      // }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xFF93AACF),
      body: Container(
        child: const Center(
          child: Image(
            image: AssetImage('assets/img/photo_2024-11-27_15-14-25-removebg-preview.png'), // تأكد من وجود الصورة في مجلد assets
            width: 500, // يمكنك تعديل العرض حسب الحاجة
            height: 500, // يمكنك تعديل الارتفاع حسب الحاجة
          ),
        ),
      ),
    );
  }
}