import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/app_constant.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/features/layout/layout_body.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/profile2.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/repositories/profile_repo_impl.dart';
import '../manager/cubit/profile_cubit.dart';

void main() {
  runApp(const EditProfileApp());
}

class EditProfileApp extends StatelessWidget {
  const EditProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  String? selectedPicture;
  DateTime? selectedDate;
  String? selectedGender;
  DateTime get _firstDate => DateTime.now().subtract(const Duration(days: 15 * 365));
  DateTime get _lastDate => DateTime.now().subtract(const Duration(days: 3 * 365));
  final List<String> images = [
    'assets/img/v (3).jpg',
    'assets/img/v (4).jpg',
    'assets/img/v (6).jpg',
    'assets/img/v (7).jpg',
    'assets/img/v__10_-removebg-preview.png',
    'assets/img/v__9_-removebg-preview.png',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameController.text = childModel!.fullName;
    emailController.text = email!;
    selectedPicture = childModel!.image;
    selectedGender = childModel!.gender;
    selectedDate = childModel!.dateOfBirth;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    fullNameController.dispose();
    dateOfBirthController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(profileRepository: getIt.get<ProfileRepoImpl>()),
  child: Scaffold(
      backgroundColor: const Color(0xFF93AACF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF93AACF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
           context.pop();
          },
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
  listener: (context, state) {
    if (state is UpdateSuccess){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Profile Updated"),

        ),
      );
    }
    if (state is UpdateFailure){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Update Failed!!"),
        ),
      );
    }
  },
  builder: (context, state) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  InkWell(
                    onTap: () => _showEditProfileSheet(context),
                    child:  CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage(selectedPicture!),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.image, color: Colors.teal, size: 24),
                  )
                ],
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 15),
              TextField(
                controller: dateOfBirthController,
                readOnly: true,
                onTap: () async {
                  final now = DateTime.now();
                  final firstDate = now.subtract(const Duration(days: 15 * 365));
                  final lastDate = now.subtract(const Duration(days: 3 * 365));

                  // Ensure initialDate is not after lastDate
                  DateTime initialDate = selectedDate ?? lastDate;
                  if (initialDate.isAfter(lastDate)) {
                    initialDate = lastDate;
                  }

                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: firstDate,
                    lastDate: lastDate,
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
              const SizedBox(height: 15),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon:  Icon(Icons.email) ,
                  labelText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              _buildPhoneField(),
              const SizedBox(height: 15),
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
              Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 3,
              ),
              onPressed: () {
                final fullName = fullNameController.text.trim();
                final newEmail = emailController.text.trim();

                if (fullName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Full Name cannot be empty")),
                  );
                  return;
                }

                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(newEmail)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enter a valid email")),
                  );
                  return;
                }

                if (selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a date of birth")),
                  );
                  return;
                }

                if (selectedGender == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select gender")),
                  );
                  return;
                }

                if (selectedPicture == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please choose a profile picture")),
                  );
                  return;
                }

                // If all validations pass, call update
                ProfileCubit.get(context).updateProfile(
                  newEmail: newEmail,
                  childData: {
                    'dateOfBirth': selectedDate!.toIso8601String(),
                    'fullName': fullName,
                    'gender': selectedGender!,
                    'image': selectedPicture!,
                  },
                );
              },

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Update",
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),
          )
             // _buildTextField(label: "Full Name"),
              //_buildTextField(label: "Nick Name"),
              //_buildTextField(label: "Date of Birth", icon: Icons.calendar_today),
             // _buildTextField(label: "Email", icon: Icons.email),

             // _buildDropdownField(),
            //  const SizedBox(height: 20),
             // _buildUpdateButton(),
             // const SizedBox(height: 10),
            ],
          ),
        ),
      );
  },
),
    ),
);
  }

  Widget _buildTextField({required String label, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: "(+20) 100-123-4567",
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("🇪🇬", style: TextStyle(fontSize: 24)),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "Gender",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
        items: ["Male", "Female"].map((gender) {
          return DropdownMenuItem(value: gender, child: Text(gender));
        }).toList(),
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildUpdateButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 3,
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Update",
              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
            ),
          ],
        ),
      ),
    );
  }
  void _showEditProfileSheet(BuildContext context) {
    String? tempSelectedPicture = selectedPicture; // temp variable to confirm on OK
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Choose a Profile Picture',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(images.length, (index) {
                      final isSelected = tempSelectedPicture == images[index];
                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            tempSelectedPicture = images[index];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: Colors.blue, width: 3)
                                : null,
                          ),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(images[index]),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pop(context); // cancel, don't save
                        },
                        child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedPicture = tempSelectedPicture; // save selection
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

