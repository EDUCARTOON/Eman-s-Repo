import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/cache_helper.dart';
import 'package:flutter_application_3/core/utils/auth_locator.dart';
import 'package:flutter_application_3/firebase_options.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/login.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/resgister.dart';
import 'package:flutter_application_3/features/auth/presentation/widgets/signup1.dart';
import 'package:flutter_application_3/splash1.dart';
import 'package:flutter_application_3/splash2.dart';
import 'package:flutter_application_3/splashscreen.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await CacheHelper.init();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      
            debugShowCheckedModeBanner: false,
      home: Splashscreen(),

    );
  }
}


