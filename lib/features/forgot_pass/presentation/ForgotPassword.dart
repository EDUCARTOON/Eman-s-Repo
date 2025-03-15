import 'package:flutter/material.dart';
import 'package:flutter_application_3/features/forgot_pass/presentation/pass_reset_sent_success_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_3/features/auth/presentation/manager/cubit/auth_cubit.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key, required this.authCubit});
  final AuthCubit authCubit;

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _forgotPassFormKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF93AACF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: BlocProvider.value(
        value: widget.authCubit,
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (cubitContext, state) {
            return BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SendResetPassSuccessState) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PassResetSentSuccessScreen(authCubit: widget.authCubit),
                    ),
                  );
                }
              },
              child: Form(
                key: _forgotPassFormKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10), // رفع الصورة للأعلى
                        const CircleAvatar(
                          radius: 150, // تكبير الصورة أكثر
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image(
                              image: AssetImage(
                                'assets/img/3d_animal_holding_a_book_back_to_school_concept___Premium_AI-generated_PSD-removebg-preview 1.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5), // تقليل المسافة بين الصورة والنص
                        const Text(
                          'Enter your email',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 15), // تقليل المسافة
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15), // تقليل المسافة
                        GestureDetector(
                          onTap: () async {
                            if (_forgotPassFormKey.currentState!.validate()) {
                              await widget.authCubit.sendPassReset(_emailController.text, context);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    '                          Send Link',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 40,
                                  height: 40,
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
                        ),
                        const SizedBox(height: 20), // تقليل المسافة للحفاظ على التناسق
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

