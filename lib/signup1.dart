import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/resgister_screen.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/routing/routes.dart';
import 'core/services/cache_helper.dart';
import 'core/services/service_locator.dart';
import 'features/auth/data/repositories/auth_repo_impl.dart';

class Signup1 extends StatelessWidget {
  const Signup1({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepository: getIt<AuthRepository>()),
      child: Scaffold(
        backgroundColor: const Color(0xFF93AACF),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state)async {
            if (state is LoginSuccessState) {
              await CacheHelper.saveData(key: 'isLogin', value: true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Login successfully"),
                ),
              );
              googleLogin?context.push(Routes.pinCodeScreen,extra: AuthCubit.get(context)):context.push(Routes.childrenScreen);
              // context.push(Routes.childrenScreen);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Profile1()),
              // );
            } else if (state is LoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.errMessage.toString()),
                ),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // صورة متحركة GIF
                  Image.asset(
                    'assets/img/gif-unscreen.gif', // المسار الصحيح للـ GIF
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20), // مسافة بين الصورة والنص
                  const Text(
                    "Let's you in",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20), // مسافة بين النص

                  // زر تسجيل الدخول باستخدام Google
                  TextButton.icon(
                    onPressed: () {
                      AuthCubit.get(context).googleLogin();
                    },
                    icon: Image.asset(
                      'assets/img/Circle.png', // ضع المسار الصحيح للصورة هنا
                      width: 24, // حجم الصورة ليكون مشابهاً للأيقونة
                      height: 24,
                    ),
                    label: const Text(
                      'Continue with Google',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                  ),

                  const SizedBox(height: 10), // مسافة بين الأزرار
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text(
                        'or', style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(height: 20),

                  // زر تسجيل الدخول مع دائرة السهم البيضاء
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Sign In with Your Account',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            RegisterScreen()),
                      );
                    },
                    style: TextButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text('Don’t have an Account? SIGN UP',
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


