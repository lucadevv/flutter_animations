import 'package:animations/home_screen/card_animation_screen.dart';
import 'package:flutter/material.dart';

class CircleAnimation extends AnimatioDecorator {
  @override
  Widget decorator(Widget widget) {
    return widget;
  }
}

class BreadScreen extends StatefulWidget {
  static const name = 'bread-screen';
  const BreadScreen({super.key});

  @override
  State<BreadScreen> createState() => _BreadScreenState();
}

class _BreadScreenState extends State<BreadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.lightGreenAccent.shade100,
          ),
          child: SizedBox(
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }
}
