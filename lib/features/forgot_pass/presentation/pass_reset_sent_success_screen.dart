import 'package:flutter/material.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_3/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:flutter_application_3/features/forgot_pass/presentation/newpassword.dart';

class PassResetSentSuccessScreen extends StatefulWidget {
  const PassResetSentSuccessScreen({super.key, required this.authCubit});
  final AuthCubit authCubit;

  @override
  State<PassResetSentSuccessScreen> createState() => _PassResetSentSuccessScreenState();
}

class _PassResetSentSuccessScreenState extends State<PassResetSentSuccessScreen> {


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
          'Reset Password',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: BlocProvider.value(
        value: widget.authCubit,
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (cubitContext, state) {
            return BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
              //  if(state is SendResetPassSuccessState){
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) =>  Newpassword(authCubit: widget.authCubit,)),
              //   );
              //  }
              },
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 150,
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
                      const SizedBox(height: 20),
                      const Text(
                        "We've sent a password reset link to your email. Please check your inbox and follow the instructions.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 30),
              
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>   const LoginScreen()),
                );

                            // if (_forgotPassFormKey.currentState!.validate()) {
                            //     await widget.authCubit.sendPassReset(_emailController.text,context);
               
                            //   // _showVerificationDialog(cubitContext);
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Color(0xFF6200EE)),
                          ),
                          child: const Text(
                            'Login Again',
                            style: TextStyle(
                              color: Color(0xFF6200EE),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
             
            );
          },
        ),
      ),
    );
  }

  /// **Shows the verification dialog**
  // void _showVerificationDialog(BuildContext cubitContext) {
  //   showDialog(
  //     context: cubitContext,
  //     builder: (BuildContext context) {
  //       return BlocProvider.value(
  //         value: widget.authCubit, //cubitContext.read<AuthCubit>(),
  //         child: AlertDialog(
  //           title: const Text("Verification Link Sent"),
  //           content: const Text(
  //               "We have sent a verification link to your email, please check it and try again."),
  //           actions: <Widget>[
  //             TextButton(
  //               child: const Text("OK"),
  //               onPressed: () async {
                   
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

}
