import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:flutter_application_3/features/profile/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_3/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:flutter_application_3/add_child_profile.dart';
import 'package:go_router/go_router.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({super.key, required this.cubit});
  final AuthCubit cubit;

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  List<String> pinList = ['', '', '', '']; // List to store entered digits

  void _addPin(String number) {
    for (int i = 0; i < pinList.length; i++) {
      if (pinList[i].isEmpty) {
        setState(() {
          pinList[i] = number; // Add number to empty box
        });
        break;
      }
    }
  }

  void _removePin() {
    for (int i = pinList.length - 1; i >= 0; i--) {
      if (pinList[i].isNotEmpty) {
        setState(() {
          pinList[i] = ''; // Remove number from box
        });
        break;
      }
    }
  }

 Future< void> _submitPin({required BuildContext cubitContext})async {
    String pinCode = pinList.join(""); // Convert pin list to string
    if (pinCode.length == 4) {
    await  cubitContext.read<AuthCubit>().addUserPinCode(pin: pinCode).then((_){
      context.push(Routes.addChildProfile,extra: true);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => const AddChildProfileScreen(
      //               )),
      // );
    });

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a 4-digit PIN")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFF93AACF),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Create New Pin',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 200,
                  width: 200,
                  child: Image(
                    image: AssetImage(
                        'assets/img/photo_2024-11-22_20-18-14-removebg-preview.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'To make sure your kids don\'t change their sensitive topics and sharing settings. You can lock the modification of these features with a secret number.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          pinList[index].isEmpty ? '*' : pinList[index],
                          style: const TextStyle(
                              fontSize: 24, color: Colors.black),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    String buttonLabel;
                    if (index < 9) {
                      buttonLabel = '${index + 1}';
                    } else if (index == 9) {
                      buttonLabel = '0';
                    } else if (index == 10) {
                      buttonLabel = '*';
                    } else {
                      buttonLabel = '×';
                    }

                    return TextButton(
                      onPressed: () {
                        if (buttonLabel == '×') {
                          _removePin();
                        } else {
                          _addPin(buttonLabel);
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.all(20),
                      ),
                      child: Text(
                        buttonLabel,
                        style:
                            const TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (cubitContext, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: ()async{await _submitPin(cubitContext: cubitContext);},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
