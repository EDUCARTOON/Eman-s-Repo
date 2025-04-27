import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/children_screen.dart';
import 'package:flutter_application_3/features/profile/data/models/child_model.dart';
import 'package:flutter_application_3/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';



class FavoriteTopicsScreen extends StatefulWidget {
  const FavoriteTopicsScreen(
      {super.key, required this.childModel, required this.profileCubit, this.isAdd});
  final ChildModel childModel;
  final ProfileCubit profileCubit;
  final bool? isAdd;
  @override
  _FavoriteTopicsScreenState createState() => _FavoriteTopicsScreenState();
}

class _FavoriteTopicsScreenState extends State<FavoriteTopicsScreen> {
  final List<String> topics = [
    'Behavior',
    'Religion',
    'Education',
    'Civilization',
    'Entertainment',
    'Technology',
  ];

  final List<String> images = [
    'assets/img/v__13_-removebg-preview (1).png',
    'assets/img/v__18_-removebg-preview 1.png',
    'assets/img/v__16_-removebg-preview (1).png',
    'assets/img/v__15_-removebg-preview (1).png',
    'assets/img/v__17_-removebg-preview 1.png',
    'assets/img/v__14_-removebg-preview 1.png',
  ];

  // قائمة لتتبع الصور التي تم اختيارها
  List<bool> selectedTopics = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.profileCubit,
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (cubitContext, state) {
          if(state is FillChildDataSuccessState) {
          //  widget.profileCubit.getUserChildren();
                      context.push(Routes.childrenScreen,);
//             Navigator.pushAndRemoveUntil(
//   context,
//   MaterialPageRoute(
//     builder: (context) => const ChildrenScreen(),
//   ),
//   (route) => false, // هذا يجعل الشاشة الجديدة هي الوحيدة في السجل
// );

          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF93AACF), // اللون الخلفي الأزرق
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 40), // مسافة من الأعلى
                const Text(
                  "Choose your favorite topics",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 8, 8, 8),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTopics[index] = !selectedTopics[index];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedTopics[index]
                                  ? const Color.fromARGB(
                                      255, 0, 0, 0) // لون الحدود عند التحديد
                                  : Colors.transparent,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                images[index],
                                width: 100, // تكبير الصورة
                                height: 100, // تكبير الصورة
                              ),
                              const SizedBox(height: 10),
                              Text(
                                topics[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D3748),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight, // تحريك السهم إلى اليسار
                  child: GestureDetector(
                    onTap: () {
                      widget.childModel.favoriteTopicsIndexes = selectedTopics
                          .asMap()
                          .entries
                          .where((entry) =>
                              entry.value == true) // Filter only true values
                          .map((entry) => entry.key) // Extract the indexes
                          .toList();
                      widget.profileCubit
                          .addChid(childModel: widget.childModel, isAdd:widget.isAdd??false );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const ReaderApp()),
                      // );
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
