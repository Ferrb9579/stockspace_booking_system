import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:animations/animations.dart';
import 'package:stockspace_booking_system/pages/splash/splash.dart';

class SharedAxisTransitionBuilder extends CustomTransition {
  final SharedAxisTransitionType transitionType;

  SharedAxisTransitionBuilder({
    this.transitionType = SharedAxisTransitionType.horizontal,
  });

  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: transitionType,
      child: child,
    );
  }
}

enum AppRoutes {
  splash,
}

class AppPages {
  static final routes = [
    GetPage(
      name: '/${AppRoutes.splash}',
      page: () => SplashPage(),
      customTransition: SharedAxisTransitionBuilder(),
    ),
  ];
}
