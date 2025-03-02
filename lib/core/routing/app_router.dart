import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Educartoon.dart';
import 'package:flutter_application_3/FavoriteTopics.dart';
import 'package:flutter_application_3/add_child_profile.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/core/services/secure_storage_sevice.dart';
import 'package:flutter_application_3/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:flutter_application_3/features/on_boarding/presentation/home.dart';
import 'package:flutter_application_3/features/on_boarding/presentation/splash/splashscreen.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/children_screen.dart';
import 'package:flutter_application_3/core/services/cache_helper.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/core/services/service_locator.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/resgister_screen.dart';
import 'package:flutter_application_3/features/courses/presentation/pages/courses_screen.dart';
import 'package:flutter_application_3/features/home/presentation/screen/home_screen.dart';
import 'package:flutter_application_3/features/inbox/presentation/cubit/inbox_cubit.dart';
import 'package:flutter_application_3/features/inbox/presentation/pages/inbox_screen.dart';
import 'package:flutter_application_3/features/layout/layout_body.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter_application_3/pin_code_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/on_boarding/presentation/splash/splash1.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
      initialLocation: Routes.welcomeScreen,
      redirect: (context, state) async {
          //  return Routes.onBoarding;
     
          bool isLogin = await CacheHelper.getData("isLogin")??false;
        log( "isLogin $isLogin");
        if (state.matchedLocation != Routes.welcomeScreen) {
          return null;
        }

        if (isLogin==false) {
          log("Redirecting to Welcome Screen");
          return Routes.splashScreen;
        } else {
          log("Redirecting to Home Screen");
          return Routes.childrenScreen;
        }
      },
      routes: <RouteBase>[
        ShellRoute(
          builder: (context, state, child) => Layout(child: child),
          routes: [
            GoRoute(
              path: Routes.homeScreen,
              builder: (context, state) => const Educartoon(),
            ),
            GoRoute(
              path: Routes.coursesScreen,
              builder: (context, state) => const CoursesScreen(),
            ),
            GoRoute(
              path: Routes.inboxScreen,
              builder: (context, state) => const InboxScreen(),
            ),
            GoRoute(
              path: Routes.profileScreen,
              builder: (context, state) => const ProfileScreen(),
            ),
            // GoRoute(
            //   path: Routes.searchScreen,
            //   builder: (context, state) {
            //     final cubitContext = state.extra as BuildContext;
            //     return BlocProvider.value(
            //       value: cubitContext.read<HomeCubit>()
            //         ..getCategoriesData()
            //         ..getALLProducts(),
            //       child: SearchScreen(cubitContext: cubitContext),
            //     );
            //   },
            // ),
            // GoRoute(
            //   path: Routes.productDetailsScreen,
            //   builder: (context, state) {
            //     final args = state.extra as Map<String, dynamic>?;
            //     return ProductDetailsScreen(
            //       product: args?['product'],
            //       cubit: args?['cubit'],
            //     );
            //   },
            // ),
            // GoRoute(
            //   path: Routes.categoryDetailsScreen,
            //   builder: (context, state) {
            //     final args = state.extra as Map<String, dynamic>?;
            //     return CategoryDetails(
            //       categoryName: args?['categoryName'],
            //       cubitContext: args?['cubitContext'],
            //       categoryId: args?['categoryId'],
            //     );
            //   },
            // ),


        
          ],
        ),
        GoRoute(
          path: Routes.loginScreen,
          builder: (BuildContext context, GoRouterState state) {
           
            return  LoginScreen();
          },
        ),
        
        GoRoute(
          path: Routes.registerScreen,
          builder: (BuildContext context, GoRouterState state) {
            return  RegisterScreen();
          },
        ),
      GoRoute(
          path: Routes.childrenScreen,
          builder: (BuildContext context, GoRouterState state) {
           
            return  const ChildrenScreen();
          },
        ),
   GoRoute(
          path: Routes.addChildProfile,
          builder: (BuildContext context, GoRouterState state) {
           
            return  const AddChildProfileScreen();
          },
        ),
           GoRoute(
          path: Routes.pinCodeScreen,
          builder: (BuildContext context, GoRouterState state) {
           
            return   PinCodeScreen(cubit: state.extra as AuthCubit,);
          },
        ),
   GoRoute(
          path: Routes.favTopicsScreen,
          builder: (BuildContext context, GoRouterState state) {
           final args = state.extra as Map<String, dynamic>?;
   
            return   FavoriteTopicsScreen(
                      childModel: args?['childModel'],
                  profileCubit: args?['profileCubit'],
            );
          },
        ),
           GoRoute(
          path: Routes.splash1sScreen,
          builder: (BuildContext context, GoRouterState state) {
   
            return   const Splash1(
              
            );
          },
        ),
     GoRoute(
          path: Routes.splashScreen,
          builder: (BuildContext context, GoRouterState state) {
            return   const Splashscreen(
            );
          },
        ),
           GoRoute(
          path: Routes.onBoarding,
          builder: (BuildContext context, GoRouterState state) {
            return   const Home(
            );
          },
        ),

        
        
        
      
      ]);
}