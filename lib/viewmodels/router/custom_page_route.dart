import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute(
      {required this.child,
        RouteSettings? settings,
        Duration duration = const Duration(milliseconds: 500)})
      : super(
      settings: settings,
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(animation),
          child: child);
}
