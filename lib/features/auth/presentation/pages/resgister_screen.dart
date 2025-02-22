import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/app_constant.dart';
import 'package:flutter_application_3/core/utils/auth_locator.dart';
import 'package:flutter_application_3/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_application_3/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:flutter_application_3/features/home/presentation/screen/home_screen.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/profile1.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// تأكد من استيراد صفحة تسجيل الدخول

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> signUpFormKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        authRepository: getIt.get<AuthRepository>(),
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text("sign up successfully"),
              ),
            );
            // AuthCubit.get(context).getUserData(uid: state.uid);
             Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Profile1()),
            );
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
          return Scaffold(
            backgroundColor: Colors.blue[200], // لون الخلفية
            body: Form(
              key: signUpFormKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/Untitled_design__3_-removebg-preview.png', // مسار اللوجو (استبدل بمسار اللوجو الفعلي)
                          width: 800,
                          height: 100,
                        ),

                        // إضافة صورة اللوجو
                        const SizedBox(height: 0), // مسافة بين الصورة والنص
                        const Text(
                          'Getting Started!                                            ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 0), // مسافة بين النص
                        const Text(
                          'Create an Account to Continue your allCourses',
                          textAlign: TextAlign.left, // محاذاة النص إلى المنتصف
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 0), // مسافة قبل حقول الإدخال
                        TextFormField(
                          controller: firstNameController,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your First Name';
                          }
                          return null;
                        },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                            validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Last Name';
                          }
                          return null;
                        },
                          controller: lastNameController,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                            validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Email';
                          }
                          return null;
                        },
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                            validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                            validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Confirm your Password';
                          }
                          return null;
                        },
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (value) {}),
                            const Text('Agree to Terms & Conditions'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            log("--------------------");
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      "please enter the same password in both fields"),
                                ),
                              );
                              return;
                            }
                            if (signUpFormKey.currentState!.validate()) {
                              await AuthCubit.get(context).register(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  firstName: firstNameController.text,
                                  image: AppConstant.kDefaultUserImage,
                                  lastName: lastNameController.text);
                            }
                            // هنا يمكنك إضافة الإجراء المطلوب عند الضغط على زر "تسجيل الاشتراك"
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                            backgroundColor: const Color.fromARGB(
                                255, 255, 255, 255), // لون الزر
                          ),
                          child: const Text('Sign Up'),
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
                              icon: const Icon(Icons
                                  .facebook), // يمكنك استخدام أي أيقونة مناسبة
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
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          },
                          child: const Text(
                            "Already have an Account? SIGN IN",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
