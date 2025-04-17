part of 'layout_cubit.dart';

abstract class LayoutState {}

class HomeInitialState extends LayoutState {}

class LayoutChangedState extends LayoutState {
  final int currentIndex;
  final Widget currentScreen;

  LayoutChangedState({required this.currentIndex, required this.currentScreen});
}