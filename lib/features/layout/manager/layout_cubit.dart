
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(HomeInitialState());

  static LayoutCubit get(BuildContext context) => BlocProvider.of(context);

  int navBarIndex = 0;
  // bool isWelcomeScreen = false;

  final List<String> navBarRoutes = [
    Routes.homeScreen,
    Routes.coursesScreen,
    Routes.inboxScreen,
    Routes.childrenScreen,
  ];

  void changeNavBar({required int index, required BuildContext context}) {
    log("=========================================$navBarIndex");
    if (navBarIndex != index) {

      navBarIndex = index;
      if(index==3){
        context.push(navBarRoutes[index]);}
        else{
      GoRouter.of(context).go(navBarRoutes[index],
       ); }// Navigate using GoRouter
      emit(NavBarState());
    }
  }



}
