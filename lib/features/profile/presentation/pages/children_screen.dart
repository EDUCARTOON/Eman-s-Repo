import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/educartoon_screen.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/features/profile/data/models/child_model.dart';
import 'package:flutter_application_3/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:go_router/go_router.dart';

class ChildrenScreen extends StatelessWidget {
  const ChildrenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => isAddChild = false,
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
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      height: 180,
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person_add, color: Colors.green),
                            title: const Text("Add Child Profile"),
                            onTap: () {
                              Navigator.pop(context);
                              isAddChild = true;
                              cubitContext.push(Routes.addChildProfile, extra: true);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.login, color: Colors.blue),
                            title: const Text("Go to Login Screen"),
                            onTap: () {
                              Navigator.pop(context);
                              context.push(Routes.loginScreen);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
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
        crossAxisCount: 2, // عدد الأعمدة
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8, // تحسين التناسق
      ),
      itemCount: children.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            childModel = children[index];
            context.go(Routes.homeScreen);
          },
          child: ProfileAvatar(
            child: children[index],
          ),
        );
      },
    );
  }
}
