import 'package:flutter/material.dart';
import 'layout_screen.dart';

class Layout extends StatelessWidget {
  const Layout({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutView(
        child: child,
      ),
    );
  }
}
