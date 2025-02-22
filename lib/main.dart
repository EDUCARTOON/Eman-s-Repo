import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/utils/bloc_observer.dart';
import 'package:flutter_application_3/features/forgot_pass/presentation/ForgotPassword.dart';
import 'package:flutter_application_3/Verification.dart';
import 'package:flutter_application_3/core/utils/auth_locator.dart';
import 'package:flutter_application_3/firebase_options.dart';
import 'package:flutter_application_3/pin.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/profile1.dart';
import 'package:flutter_application_3/signup1.dart';
import 'package:flutter_application_3/features/on_boarding/presentation/splash/splash1.dart';
import 'package:flutter_application_3/features/on_boarding/presentation/splash/splash2.dart';
import 'package:flutter_application_3/features/on_boarding/presentation/splash/splashscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
      Bloc.observer = MyBlocObserver();

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
      debugShowCheckedModeBanner :false,
      home:Splashscreen()
    );
  }
}


