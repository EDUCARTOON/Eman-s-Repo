import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/educartoon_screen.dart';
import 'package:flutter_application_3/FavoriteTopics.dart';
import 'package:flutter_application_3/add_child_profile.dart';
import 'package:flutter_application_3/core/app_shared_variables.dart';
import 'package:flutter_application_3/core/services/secure_storage_sevice.dart';
import 'package:flutter_application_3/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:flutter_application_3/features/on_boarding/presentation/home.dart';
import 'package:flutter_application_3/features/on_boarding/presentation/splash/splashscreen.dart';
import 'package:flutter_application_3/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:flutter_application_3/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/children_screen.dart';
import 'package:flutter_application_3/core/services/cache_helper.dart';
import 'package:flutter_application_3/core/routing/routes.dart';
import 'package:flutter_application_3/core/services/service_locator.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_application_3/features/auth/presentation/pages/resgister_screen.dart';
import 'package:flutter_application_3/features/courses/presentation/pages/courses_screen.dart';
import 'package:flutter_application_3/features/home/presentation/screen/home_screen.dart';
import 'package:flutter_application_3/features/inbox/presentation/cubit/inbox_cubit.dart';
import 'package:flutter_application_3/features/inbox/presentation/pages/ChatBotApp.dart';
import 'package:flutter_application_3/features/layout/layout_body.dart';
import 'package:flutter_application_3/features/profile/presentation/pages/profile2.dart';
import 'package:flutter_application_3/main.dart';
import 'package:flutter_application_3/pin_code_screen.dart';
import 'package:flutter_application_3/top.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/on_boarding/presentation/splash/splash1.dart';
import '../../features/popular_courses/presentation/pages/popular.dart';
import '../../features/profile/presentation/pages/EditProfile.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(
      initialLocation: Routes.welcomeScreen,
      redirect: (context, state) {
        if (state.matchedLocation != Routes.welcomeScreen) {
          return null;
        }
        if (!isLogin == false) {
          log("Redirecting to Welcome Screen");
          return Routes.splashScreen;
        } else {
          log("Redirecting to Home Screen");
          return Routes.childrenScreen;
        }
      },
      routes: [
        GoRoute(
          path: Routes.homeScreen,
          builder: (context, state) => const EducartoonScreen(
            course: null,
            courseTitle: '',
          ),
        ),
        GoRoute(
          path: Routes.coursesScreen,
          builder: (context, state) => const CoursesScreen(),
        ),
        GoRoute(
          path: Routes.inboxScreen,
          builder: (context, state) => const ChatBotApp(),
        ),
        GoRoute(
          path: Routes.profileScreen,
          builder: (context, state) => Profile2Page(
            onDarkModeToggle: () {},
          ),
        ),
        GoRoute(
          path: Routes.popularCoursesScreen,
          builder: (context, state) => const Popular(),
        ),
        GoRoute(
          path: Routes.topScoreScreen,
          builder: (context, state) => const TopScoreScreen(),
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

        GoRoute(
          path: Routes.layoutScreen,
          builder: (context, state) => const Layout(),
        ),
        GoRoute(
          path: Routes.loginScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),

        GoRoute(
          path: Routes.registerScreen,
          builder: (BuildContext context, GoRouterState state) {
            return RegisterScreen();
          },
        ),
        GoRoute(
          path: Routes.childrenScreen,
          builder: (BuildContext context, GoRouterState state) {
//             if(state.extra!=null){
//                return  BlocProvider.value(
// value:  state.extra as ProfileCubit, //ProfileCubit(profileRepository:  getIt.get<ProfileRepoImpl>())..getUserChildren(),
//     child:
//               const ChildrenScreen());
//             }
            log("================---");
            return BlocProvider(
                create: (context) => ProfileCubit(
                    profileRepository: getIt.get<ProfileRepoImpl>())
                  ..getUserChildren(),
                child: const ChildrenScreen());
          },
        ),
        GoRoute(
          path: Routes.addChildProfile,
          builder: (BuildContext context, GoRouterState state) {
            return AddChildProfileScreen(
              isAdd: state.extra as bool,
            );
          },
        ),
        GoRoute(
          path: Routes.pinCodeScreen,
          builder: (BuildContext context, GoRouterState state) {
            return PinCodeScreen(
              cubit: state.extra as AuthCubit,
            );
          },
        ),
        GoRoute(
          path: Routes.favTopicsScreen,
          builder: (BuildContext context, GoRouterState state) {
            final args = state.extra as Map<String, dynamic>?;

            return FavoriteTopicsScreen(
              childModel: args?['childModel'],
              profileCubit: args?['profileCubit'],
              isAdd: args?['isAdd'],
            );
          },
        ),
        GoRoute(
          path: Routes.splash1sScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const Splash1();
          },
        ),
        GoRoute(
          path: Routes.splashScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const Splashscreen();
          },
        ),
        GoRoute(
          path: Routes.onBoarding,
          builder: (BuildContext context, GoRouterState state) {
            return const Home();
          },
        ),

        GoRoute(
          path: Routes.editProfileScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const EditProfileApp();
          },
        ),
      ]);
}
