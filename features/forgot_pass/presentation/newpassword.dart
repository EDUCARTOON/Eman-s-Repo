import 'package:flutter/material.dart';
import 'package:flutter_application_3/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:flutter_application_3/features/forgot_pass/presentation/CongratulationsScreen.dart';
import 'package:flutter_application_3/Verification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class Newpassword extends StatefulWidget {
//   const Newpassword({super.key});

//   @override
//   State<Newpassword> createState() => _NewpasswordState();
// }

// class _NewpasswordState extends State<Newpassword> {

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CreatePasswordScreen(),
//     );
//   }
// }

class Newpassword extends StatefulWidget {
  const Newpassword({super.key, required this.authCubit});
  final AuthCubit authCubit;

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<Newpassword> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
        final GlobalKey<FormState> newPassFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF93AACF),
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Color.fromARGB(255, 0, 0, 0)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Verification()),
                );
              },
            ),
            const SizedBox(width: 8),
            const Text(
              'New password ',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF93AACF),
      ),
      body: BlocProvider.value(
        value: widget.authCubit,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if(state is ResetPassSuccessState){Navigator.push(context, MaterialPageRoute(builder: (context) => const CongratulationsScreen(),));}
          },
          builder: (context, state) {
            return Form(
              key: newPassFormKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/img/Free_Photo___3d_rendering_of_cartoon_like_boy_reading-removebg-preview 1.png',
                          width: 200,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Create Your New Password',
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      TextField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (newPassFormKey.currentState!.validate()) {
                          context.read<AuthCubit>().resetPass(passwordController.text, context);
                          }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           const CongratulationsScreen()),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                        ),
                      ),
                    ],
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
