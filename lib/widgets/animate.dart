import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation({required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
      opacity: 1.0,
      child: Transform.translate(
        offset: Offset(0, 0),
        child: child,
      ),
    );
  }
}
