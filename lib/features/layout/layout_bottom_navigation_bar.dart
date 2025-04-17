import 'package:flutter/material.dart';
import 'package:flutter_application_3/features/layout/manager/layout_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutNavigationBar extends StatelessWidget {
  const LayoutNavigationBar({super.key, required this.currentIndex});
final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return
         BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            LayoutCubit.get(context).changeNavBar(index: index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'MY COURSES',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inbox),
              label: 'chatbot',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'PROFILE',
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        );


  }
}
