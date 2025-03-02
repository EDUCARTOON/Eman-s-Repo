
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/services/service_locator.dart';
import 'package:flutter_application_3/features/layout/layout_bottom_navigation_bar.dart';
import 'package:flutter_application_3/features/layout/manager/layout_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => getIt<LayoutCubit>(),
      child: BlocBuilder<LayoutCubit, LayoutState>(builder: (context, state) {
        // LayoutCubit cubit = LayoutCubit.get(context);
        return Stack(
            children: [
              child,
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(child: LayoutNavigationBar()),
                ],
              ),
            ],
          );
      }),
    );
  }
}
