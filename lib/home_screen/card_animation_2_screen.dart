import 'dart:math' as math;
import 'package:animations/core/utils/animated_decorator.dart';
import 'package:animations/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FitrsCardAnimation extends AnimatedDecorator {
  final Animation cardAnimation;

  FitrsCardAnimation({required this.cardAnimation});
  @override
  Widget decorator(Widget widgetOne, Widget? widgetTwo) {
    return AnimatedBuilder(
      animation: cardAnimation,
      builder: (context, child) {
        //firts widget
        final value = cardAnimation.value * (math.pi * -0.3);
        //second widget
        final valueRotationZ = cardAnimation.value * (math.pi * -0.4);
        final valueTranslateY = cardAnimation.value * (math.pi * 12);
        final valueTranslateX = cardAnimation.value * (math.pi * 12);

        return Stack(
          alignment: Alignment.center,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateZ(valueRotationZ)
                ..translate(valueTranslateX, -valueTranslateY, 0.0),
              child: widgetTwo,
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..setRotationZ(value),
              child: child,
            ),
          ],
        );
      },
      child: widgetOne,
    );
  }
}

class SecondAnimation extends AnimatedDecorator {
  final Animation cardAnimation;

  SecondAnimation({required this.cardAnimation});
  @override
  Widget decorator(Widget widgetOne, Widget? widgetTwo) {
    return AnimatedBuilder(
        animation: cardAnimation,
        builder: (BuildContext context, Widget? child) {
          final tranlateX = cardAnimation.value * (math.pi * 50);
          final valueScale = (1.0 - ((cardAnimation.value / 8)));
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..translate(0.0, -tranlateX, 0.0)
              ..scale(valueScale, valueScale, 1.0),
            child: widgetOne,
          );
        },
        child: widgetOne);
  }
}

class SecondAnimationCircleWidget extends AnimatedDecorator {
  final Animation cardAnimation;

  SecondAnimationCircleWidget({required this.cardAnimation});
  @override
  Widget decorator(Widget widgetOne, Widget? widgetTwo) {
    return AnimatedBuilder(
        animation: cardAnimation,
        builder: (BuildContext context, Widget? child) {
          final valueScale = cardAnimation.value;
          final valueTranslateY = valueScale * (math.pi * 40);

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0033)
              ..translate(0.0, valueTranslateY, 0.0)
              ..scale(valueScale, valueScale, 1.0),
            child: widgetOne,
          );
        },
        child: widgetOne);
  }
}

class CardAnimation2Screen extends StatefulWidget {
  static const name = "card-screen-2";
  const CardAnimation2Screen({super.key});

  @override
  State<CardAnimation2Screen> createState() => _CardAnimation2ScreenState();
}

class _CardAnimation2ScreenState extends State<CardAnimation2Screen>
    with TickerProviderStateMixin {
  Widget firtsCardWidget = CustomCardWidget();
  Widget secondCardWidget = CustomCardWidget(
    colorCard: Colors.white70,
  );
  // Widget circleWidget = CircleWidget();
  late AnimationController _cardAnimationController;
  late Animation _cardAnimation;

  late AnimationController _cardAnimationSecondContoller;
  late Animation _cardAnimationSecond;

  @override
  void initState() {
    _cardAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _cardAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    firtsCardWidget = FitrsCardAnimation(cardAnimation: _cardAnimation)
        .decorator(firtsCardWidget, secondCardWidget);
    _cardAnimationSecondContoller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _cardAnimationSecond = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardAnimationSecondContoller,
        curve: Curves.easeInOut,
      ),
    );
    firtsCardWidget = SecondAnimation(cardAnimation: _cardAnimationSecond)
        .decorator(firtsCardWidget, null);
    WidgetsBinding.instance.addPostFrameCallback((duration) async {
      await Future.delayed(const Duration(milliseconds: 1000));
      _cardAnimationController.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _cardAnimationController.dispose();
    _cardAnimationSecondContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: size.height * 0.4,
              child: SizedBox(
                height: size.height * 0.3,
                width: size.width,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    Colors.primaries.length,
                    (index) {
                      return SecondAnimationCircleWidget(
                        cardAnimation: _cardAnimationSecond,
                      ).decorator(
                        CircleWidget(
                          index: index,
                          voidCallback: () {},
                        ),
                        null,
                      );
                    },
                  ),
                ),
              ),
            ),
            firtsCardWidget,
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _cardAnimationController.reverse();
                              },
                              icon: Icon(Icons.arrow_back),
                            ),
                            IconButton(
                              onPressed: () {
                                _cardAnimationController.forward();
                              },
                              icon: Icon(Icons.play_arrow),
                            ),
                            IconButton(
                              onPressed: () {
                                _cardAnimationController.reset();
                              },
                              icon: Icon(Icons.restart_alt),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _cardAnimationSecondContoller.reverse();
                                setState(() {});
                              },
                              icon: Icon(Icons.arrow_back),
                            ),
                            IconButton(
                              onPressed: () {
                                _cardAnimationSecondContoller.forward();
                                setState(() {});
                              },
                              icon: Icon(Icons.play_arrow),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {});
                                _cardAnimationSecondContoller.reset();
                              },
                              icon: Icon(Icons.restart_alt),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CircleWidget extends StatelessWidget {
  const CircleWidget({super.key, this.index = 1, required this.voidCallback});

  final int index;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.primaries[index],
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: voidCallback,
        child: SizedBox(
          height: 60,
          width: 60,
        ),
      ),
    );
  }
}

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({
    super.key,
    this.colorCard = Colors.blueGrey,
  });

  final Color colorCard;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: colorCard, borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: 220,
        width: 350,
        child: Stack(
          children: [
            Positioned(
              top: 24,
              right: 16,
              child: SvgPicture.asset(
                AppImages.visaSvg,
                colorFilter: ColorFilter.mode(
                    colorCard == Colors.blueGrey ? Colors.white : Colors.black,
                    BlendMode.srcIn),
                height: 40,
                width: 40,
              ),
            ),
            Positioned(
              bottom: 24,
              left: 16,
              child: SvgPicture.asset(
                AppImages.simcardSvg,
                height: 60,
                width: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
