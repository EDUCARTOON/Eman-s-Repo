
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/features/courses/presentation/pages/courses_screen.dart';
import 'package:flutter_application_3/features/home/presentation/screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../educartoon_screen.dart';
import '../../inbox/presentation/pages/ChatBotApp.dart';
import '../../profile/presentation/pages/profile2.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(HomeInitialState());

  static LayoutCubit get(BuildContext context) => BlocProvider.of(context);

  final List<Widget> navBarWidget = [
    const EducartoonScreen(course: null, courseTitle: '',),
    const CoursesScreen(),
    const ChatBotApp(),
    Profile2Page(onDarkModeToggle: () {}),
  ];

  void changeNavBar({required int index}) {
    log("Changing nav index to $index");
    emit(LayoutChangedState(currentIndex: index, currentScreen: navBarWidget[index]));
  }



}
