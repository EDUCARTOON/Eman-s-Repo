import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/services/service_locator.dart';
import 'package:flutter_application_3/features/profile/data/models/user_model.dart';
import 'package:flutter_application_3/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:flutter_application_3/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../pin_code_screen.dart';

class Profile1 extends StatefulWidget {
  const Profile1({super.key});

  @override
  State<Profile1> createState() => _Profile1State();
}

class _Profile1State extends State<Profile1> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  int? selectedYear;
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(profileRepository:  getIt.get<ProfileRepoImpl>()),
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
            'Fill Your Profile',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (cubitContext, state) {
            if (state is FillUserDataSuccessState) {
              // Navigator.push(
              //   cubitContext,
              //   MaterialPageRoute(builder: (context) =>  Pin(cubit:cubitContext.read<ProfileCubit>())),
              // );
            } else if (state is FillUserDataErrorState) {
              ScaffoldMessenger.of(cubitContext).showSnackBar(
                SnackBar(content: Text(state.errMessage)),
              );
            }
          },
          builder: (context, state) {
            var cubit = context.read<ProfileCubit>();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.edit,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Full Name Input
                    TextField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Year Dropdown
                    DropdownButtonFormField<int>(
                      value: selectedYear,
                      decoration: InputDecoration(
                        labelText: 'Year',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: List.generate(56, (index) {
                        int year = index + 20;
                        return DropdownMenuItem(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }),
                      onChanged: (value) {
                        selectedYear = value;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Country & Phone Number
                    Column(
                      children: [
                        DropdownButtonFormField<String>(
                          value: selectedCountry,
                          decoration: InputDecoration(
                            labelText: 'Country',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          items: [
                            {'name': 'United States', 'code': '+1'},
                            {'name': 'United Kingdom', 'code': '+44'},
                            {'name': 'Australia', 'code': '+61'},
                            {'name': 'Egypt', 'code': '+20'},
                            {'name': 'India', 'code': '+91'},
                            {'name': 'Germany', 'code': '+49'},
                            {'name': 'France', 'code': '+33'},
                            {'name': 'China', 'code': '+86'},
                            {'name': 'Japan', 'code': '+81'}
                          ].map((country) {
                            return DropdownMenuItem(
                              value: country['code'],
                              child: Text('${country['name']} (${country['code']})'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedCountry = value;
                          },
                        ),
                        const SizedBox(height: 10),

                        // Phone Number Input
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          cubit.fillUserProfile(
                             profileModel: UserModel(
                              name: fullNameController.text, year: selectedYear!,
                               country: selectedCountry!, phoneNumber: phoneController.text,
                                image: '',),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Continue',
                              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                            ),
                            SizedBox(width: 10),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Color.fromARGB(255, 0, 0, 0),
                              child: Icon(Icons.arrow_forward, color: Color.fromARGB(255, 255, 251, 251), size: 16),
                            ),
                          ],
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
}
