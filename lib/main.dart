import 'package:flutter/material.dart';
import 'package:flutter_application_3/ForgotPassword.dart';
import 'package:flutter_application_3/Verification.dart';
import 'package:flutter_application_3/login.dart';
import 'package:flutter_application_3/pin.dart';
import 'package:flutter_application_3/profile1.dart';
import 'package:flutter_application_3/resgister.dart';
import 'package:flutter_application_3/signup1.dart';
import 'package:flutter_application_3/splash1.dart';
import 'package:flutter_application_3/splash2.dart';
import 'package:flutter_application_3/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:Splashscreen()
    );
  }
}


