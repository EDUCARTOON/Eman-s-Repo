import 'package:flutter/material.dart';
import 'package:flutter_application_3/FavoriteTopics.dart';
import 'package:flutter_application_3/features/profile/data/models/child_model.dart';
import 'package:flutter_application_3/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileKids extends StatefulWidget {
  const ProfileKids({super.key, required this.profileCubit});
  final ProfileCubit profileCubit;

  @override
  _ProfileKidsState createState() => _ProfileKidsState();
}

class _ProfileKidsState extends State<ProfileKids> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  String? selectedPicture;
  DateTime? selectedDate;
  String? selectedGender;

  final List<String> images = [
    'assets/img/v (3).jpg',
    'assets/img/v (4).jpg',
    'assets/img/v (6).jpg',
    'assets/img/v (7).jpg',
    'assets/img/v__10_-removebg-preview.png',
    'assets/img/v__9_-removebg-preview.png',
  ];

  @override

  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.profileCubit,
      child: Scaffold(
        backgroundColor: const Color(0xFF93AACF),
        appBar: AppBar(
          title: const Text('Profile kids'),
          backgroundColor: const Color(0xFF93AACF),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: selectedPicture != null
                      ? AssetImage(selectedPicture!)
                      : null,
                  child: selectedPicture == null
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
                      : null,
                ),
                const SizedBox(height: 30),
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
                TextField(
                  controller: dateOfBirthController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                        dateOfBirthController.text =
                            "${pickedDate.toLocal()}".split(' ')[0];
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Male', child: Text('Male')),
                    DropdownMenuItem(value: 'Female', child: Text('Female')),
                    DropdownMenuItem(value: 'Other', child: Text('Other')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                const Text('Choose your account picture:'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: List.generate(images.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPicture = images[index];
                        });
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(images[index]),
                        child: selectedPicture == images[index]
                            ? const Icon(Icons.check, color: Colors.black)
                            : null,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                Center(
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (cubitContext, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (fullNameController.text.isEmpty ||
                              selectedDate == null ||
                              selectedGender == null ||
                              selectedPicture == null) {
                            ScaffoldMessenger.of(cubitContext).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill all fields'),
                              ),
                            );
                            return;
                          }

                          ChildModel child = ChildModel(
                            image: selectedPicture!,
                            fullName: fullNameController.text,
                            dateOfBirth: selectedDate!,
                            gender: selectedGender!,
                            favoriteTopicsIndexes: [], // Add selected topics later
                          );

                          Navigator.push(
                            cubitContext,
                            MaterialPageRoute(
                              builder: (context) => FavoriteTopicsScreen(
                                childModel: child,
                                profileCubit: cubitContext.read<ProfileCubit>(),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                        ),
                        child: const Text('Continue'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
