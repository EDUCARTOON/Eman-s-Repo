import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/app_constant.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/core/services/cache_helper.dart';
import 'package:flutter_application_3/core/services/service_locator.dart';
import 'package:flutter_application_3/core/utils/auth_locator.dart';
import 'package:flutter_application_3/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter_application_3/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/profile1.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> signUpFormKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
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
        listener: (cubitContext, state)async {
          if (state is RegisterSuccessState) {
            ScaffoldMessenger.of(cubitContext).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text("Sign up successfully"),
              ),
            );
                        await CacheHelper.saveData(key: 'isLogin', value: true);
          
            // AuthCubit.get(context).getUserData(uid: state.uid);
            context.push(Routes.pinCodeScreen,extra: cubitContext.read<AuthCubit>());
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => const Profile1()),
            // );
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(cubitContext).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.errMessage.toString()),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(automaticallyImplyLeading: true,elevation: 0,backgroundColor: Colors.transparent,),
            backgroundColor:const Color(0xFF93AACF),
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
                          'assets/img/Untitled_design__3_-removebg-preview.png',
                          width: 800,
                          height: 100,
                        ),
                        const SizedBox(height: 10),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Getting Started!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Create an Account to Continue your allCourses',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(firstNameController, 'First Name'),
                        const SizedBox(height: 20),
                        _buildTextField(lastNameController, 'Last Name'),
                        const SizedBox(height: 20),
                        _buildTextField(emailController, 'Email'),
                        const SizedBox(height: 20),
                        _buildTextField(passwordController, 'Password', obscureText: true),
                        const SizedBox(height: 20),
                        _buildTextField(confirmPasswordController, 'Confirm Password', obscureText: true),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (value) {}),
                            const Text('Agree to Terms & Conditions'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            log("--------------------");
                            if (passwordController.text != confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Please enter the same password in both fields"),
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
                                lastName: lastNameController.text,
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Or Continue With"),
                        const SizedBox(height: 10),
                        Image.asset('assets/img/Circle.png', width: 50, height: 50),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text(
                            "Already have an Account? SIGN IN",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
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

  Widget _buildTextField(TextEditingController controller, String labelText, {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
    );
  }
}


