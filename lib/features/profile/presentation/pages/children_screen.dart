import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/Educartoon.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/core/services/service_locator.dart';
import 'package:flutter_application_3/features/profile/data/models/child_model.dart';
import 'package:flutter_application_3/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:flutter_application_3/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:flutter_application_3/add_child_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:go_router/go_router.dart';


// void main() {
//   runApp(const ReaderApp());
// }

// class ReaderApp extends StatelessWidget {
//   const ReaderApp({super.key,});
//   // final ProfileCubit profileCubit;

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ReaderSelectionScreen(),
//     );
//   }
// }

class ChildrenScreen extends StatelessWidget {
  const ChildrenScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
create: (context) => ProfileCubit(profileRepository:  getIt.get<ProfileRepoImpl>())..getUserChildren(),
    child: Scaffold(
        backgroundColor: const Color(0xFF93AACF), // اللون الخلفي الأزرق
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 40), // مسافة من الأعلى
              const Text(
                "Who will read today?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Choose the account by clicking on your picture",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is GetUserChildrenLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetUserChildrenSuccessState) {
                      return ChildrenList(
                        children: state.children,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (cubitContext, state) {
            return FloatingActionButton(
              onPressed: () {
                log("clicked");
                cubitContext.push(Routes.addChildProfile);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const AddChildProfileScreen(
                //             // profileCubit: cubitContext.read<ProfileCubit>(),
                //           )),
                // );
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            );
          },
        ),

        //  FloatingActionButton(onPressed: () {
        //
        // },
        //   child:
        // ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final ChildModel child;

  const ProfileAvatar({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(child.image),
        ),
        const SizedBox(height: 10),
        Text(
          child.fullName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class ChildrenList extends StatelessWidget {
  final List<ChildModel> children;

  const ChildrenList({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust the number of columns as needed
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8, // Adjust for better layout
      ),
      itemCount: children.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
             childModel=children[index];
             context.go(Routes.homeScreen);
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => const Educartoon()),
            //     (route) => false,
            // );
          },
          child: ProfileAvatar(
            child: children[index],
          ),
        );
      },
    );
  }
}
