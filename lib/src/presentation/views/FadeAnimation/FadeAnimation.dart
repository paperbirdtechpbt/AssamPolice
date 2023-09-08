import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  final int delay;
  final Widget child;
  final AnimationController? animationController;

  FadeAnimation(this.delay, this.animationController, this.child);

  @override
  Widget build(BuildContext context) {
    double _animationStart = 0.1 * delay;
    double _animationEnd = _animationStart + 0.4;

    return SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, 0.3), end: Offset(0.0, 0.0))
          .animate(CurvedAnimation(
              parent: animationController!,
              curve: Interval(_animationStart, _animationEnd,
                  curve: Curves.ease))),
      child: FadeTransition(
          opacity: Tween(begin: 0.5, end: 1.0).animate(animationController!),
          child: child),
    );
  }
}
