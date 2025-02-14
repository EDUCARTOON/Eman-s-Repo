import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/utils/auth_locator.dart';
import 'package:flutter_application_3/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_application_3/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/resgister.dart';
import 'package:flutter_application_3/features/auth/presentation/widgets/signup1.dart';
import 'package:flutter_application_3/features/home/presentation/screen/home_screen.dart';
import 'package:flutter_application_3/sigunp1.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  final GlobalKey<FormState> signInFormKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        authRepository: getIt.get<AuthRepository>(),
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text("Login successfully"),
              ),
            );
            // AuthCubit.get(context).getUserData(uid: state.uid);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
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
              key: signInFormKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          textAlign: TextAlign.left, // محاذاة النص إلى المنتصف
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(133, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(height: 40),
                         TextField(
                          controller: emailController,
                          decoration:const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        const SizedBox(height: 20),
                         TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration:const InputDecoration(
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
                                // هنا يمكنك إضافة الإجراء المطلوب عند الضغط على زر "نسيت كلمة المرور"
                              },
                              child: const Text('Forgot Password?'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // تعديل زر "Sign In" لاحتواء دائرة سوداء مع سهم أبيض
                        ElevatedButton(
                          onPressed: () async {
                            // هنا يمكنك إضافة الإجراء المطلوب عند الضغط على زر "تسجيل الدخول"

                            if (signInFormKey.currentState!.validate()) {
                              await AuthCubit.get(context).login(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            backgroundColor: const Color.fromARGB(
                                255, 253, 254, 255), // لون الزر
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Sign In',
                                  style: TextStyle(color: Colors.black)),
                              SizedBox(width: 10), // مسافة بين النص والسهم
                              // تحريك الدائرة قليلاً إلى اليمين وتكبير حجمها
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0), // تحريكها لليمين قليلاً
                                child: CircleAvatar(
                                  radius: 25, // تكبير حجم الدائرة
                                  backgroundColor: Colors.black, // لون الدائرة
                                  child: Icon(
                                    Icons.arrow_forward, // السهم الأبيض
                                    color: Colors.white, // لون السهم
                                    size: 20, // حجم السهم
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
                              MaterialPageRoute(
                                  builder: (context) => Resgister()),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
