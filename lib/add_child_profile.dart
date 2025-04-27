import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/core/services/service_locator.dart';
import 'package:flutter_application_3/features/profile/data/models/child_model.dart';
import 'package:flutter_application_3/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:flutter_application_3/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddChildProfileScreen extends StatefulWidget {
  const AddChildProfileScreen({super.key, this.isAdd});
  final bool? isAdd;

  @override
  _AddChildProfileScreenState createState() => _AddChildProfileScreenState();
}

class _AddChildProfileScreenState extends State<AddChildProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

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

  DateTime get _firstDate => DateTime.now().subtract(const Duration(days: 15 * 365));
  DateTime get _lastDate => DateTime.now().subtract(const Duration(days: 3 * 365));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(profileRepository: getIt.get<ProfileRepoImpl>()),
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
                      initialDate: selectedDate ?? _lastDate,
                      firstDate: _firstDate,
                      lastDate: _lastDate,
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                        dateOfBirthController.text = "${pickedDate.toLocal()}".split(' ')[0];
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
                  child: GestureDetector(
                    onTap: () {
                      if (fullNameController.text.isEmpty ||
                          selectedDate == null ||
                          selectedGender == null ||
                          selectedPicture == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
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
                        favoriteTopicsIndexes: [],
                      );
                      context.push(Routes.favTopicsScreen, extra: {
                        'childModel': child,
                        'profileCubit': context.read<ProfileCubit>(),
                        'isAdd': widget.isAdd ?? false,
                      });
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                '                  Continue',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
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