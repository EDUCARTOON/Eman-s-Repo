import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/core/routing/app_router.dart';
import 'package:flutter_application_3/core/services/cache_helper.dart';
import 'package:flutter_application_3/core/services/secure_storage_sevice.dart';
import 'package:flutter_application_3/core/utils/bloc_observer.dart';
import 'package:flutter_application_3/features/forgot_pass/presentation/ForgotPassword.dart';
import 'package:flutter_application_3/Verification.dart';
import 'package:flutter_application_3/core/services/service_locator.dart';
import 'package:flutter_application_3/firebase_options.dart';
import 'package:flutter_application_3/pin_code_screen.dart';
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
    setupLocator();
      Bloc.observer = MyBlocObserver();
// await getIt<CacheHelper>().init();
  await CacheHelper.init();
     uid =
            await getIt<SecureStorageServices>().getData(key: 'UID')??"";
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
     routerConfig: AppRouter.router,
      debugShowCheckedModeBanner :false,
      // home:Splashscreen()
    );
  }
}


