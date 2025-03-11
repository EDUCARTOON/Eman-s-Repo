import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/children_screen.dart';
import 'package:flutter_application_3/core/services/cache_helper.dart';
import 'package:flutter_application_3/features/forgot_pass/presentation/ForgotPassword.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/resgister_screen.dart';
import 'package:flutter_application_3/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/profile1.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_3/core/services/service_locator.dart';
import 'package:flutter_application_3/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_application_3/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> signInFormKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepository: getIt.get<AuthRepository>()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state)async {
          if (state is LoginSuccessState) {
            await CacheHelper.saveData(key: 'isLogin', value: true);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text("Login successfully"),
              ),
            );
            context.push(Routes.childrenScreen);
//             Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => const ChildrenScreen(),
//   ),
//   // هذا يجعل الشاشة الجديدة هي الوحيدة في السجل
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
        builder: (cubitContext, state) {
          return Scaffold(
            backgroundColor: const Color(0xFF93AACF),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: signInFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/Untitled_design__3_-removebg-preview.png',
                        width: 800,
                        height: 100,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Let’s Sign In.!',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 0),
                      const Text(
                        'Login to Your Account to Continue your Courses',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(133, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                           validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
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
                                cubitContext,
                                MaterialPageRoute(builder: (context) =>ForgotPassword(authCubit:cubitContext.read<AuthCubit>())),
                              );
                            },
                            child: const Text('Forgot Password?'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (signInFormKey.currentState!.validate()) {
                            await AuthCubit.get(cubitContext).login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                          backgroundColor: Colors.white,
                        ),
                        child: const Text('Sign In', style: TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            cubitContext,
                            MaterialPageRoute(builder: (context) =>  RegisterScreen()),
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
          );
        },
      ),
    );
  }
}
