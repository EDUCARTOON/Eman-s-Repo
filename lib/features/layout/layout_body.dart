import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../profile/presentation/pages/profile2.dart';
import 'layout_bottom_navigation_bar.dart';
import 'manager/layout_cubit.dart';

class Layout extends StatelessWidget {
  const Layout({super.key,  this.id=0});
final int id ;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
  create: (context) => LayoutCubit(),
  child: BlocBuilder<LayoutCubit, LayoutState>(
  builder: (context, state) {
    final cubit = LayoutCubit.get(context);
    final currentIndex =id == 4?3: (state is LayoutChangedState) ? state.currentIndex : 0;
    final currentScreen =id == 4?Profile2Page(onDarkModeToggle: () {}): (state is LayoutChangedState) ? state.currentScreen : cubit.navBarWidget[0];
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar:  LayoutNavigationBar(currentIndex:currentIndex ,),
      body:currentScreen,
    );
  },
),
);
  }
}
