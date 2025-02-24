import 'package:animations/home_screen/home_screen.dart';

import 'package:flutter/material.dart';

abstract class AnimationDecorator {
  Widget decorate(Widget widget);
}

class ZoomOutAnimation extends AnimationDecorator {
  final Animation animation;

  ZoomOutAnimation({required this.animation});
  @override
  Widget decorate(Widget widget) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final value = animation.value;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..scale(value, value, 1.0),
            child: widget,
          );
        },
        child: widget);
  }
}

class SplashScreen extends StatefulWidget {
  static const name = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Widget lucadevWidget = Lucadev();
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<double>(begin: -1.5, end: 1.5).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.elasticOut));
    lucadevWidget =
        ZoomOutAnimation(animation: _animation).decorate(lucadevWidget);
    _animationController.forward();
    _animationController.addStatusListener((state) {
      if (state.isCompleted) {
        Navigator.pushReplacementNamed(context, HomeScreen.name);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: lucadevWidget,
      ),
    );
  }
}

class Lucadev extends StatelessWidget {
  const Lucadev({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      "LUCADEVV",
      style: textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
