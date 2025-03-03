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
              child: widgetOne,
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

  final Offset initialOffset;

  SecondAnimationCircleWidget({
    required this.cardAnimation,
    required this.initialOffset,
  });
  @override
  Widget decorator(Widget widgetOne, Widget? widgetTwo) {
    return AnimatedBuilder(
      animation: cardAnimation,
      builder: (BuildContext context, Widget? child) {
        final valueScale = (2.0 - (cardAnimation.value)).clamp(1.0, 2.0);
        final translateX = initialOffset.dx * (1 - cardAnimation.value);
        final translateY = initialOffset.dy * (1 - cardAnimation.value);
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.004)
            ..translate(translateX, translateY, 0.0)
            ..scale(valueScale, valueScale, -20)
            ..translate(1.0, 130.0, 0.0),
          child: widgetOne,
        );
      },
      child: widgetOne,
    );
  }
}

class TertaryCardAnimation extends AnimatedDecorator {
  final Animation cardAnimation;

  TertaryCardAnimation({required this.cardAnimation});
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
              child: widgetOne,
            ),
          ],
        );
      },
      child: widgetOne,
    );
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
    colorCard: Colors.white,
  );
  late Widget? circleWidget = CircleWidget(voidCallback: () {});

  late AnimationController _cardAnimationController;
  late Animation _cardAnimation;

  late AnimationController _cardAnimationSecondContoller;
  late Animation _cardAnimationSecond;

  late AnimationController _cardAnimationTertiaryContoller;
  late Animation _cardAnimationTertiary;

  late List<Offset> _initialOffsets;
  late List<Animation> _circleAnimations;
  final int itemCount = 10;

  @override
  void initState() {
    //----------firts animation----------
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
    WidgetsBinding.instance.addPostFrameCallback((duration) async {
      await Future.delayed(const Duration(milliseconds: 800));
      _cardAnimationController.forward();
    });
    //----------firts animation----------
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

    _initialOffsets = List.generate(itemCount, (index) {
      return Offset(
        (index % 2 == 0) ? -200.0 : 200.0,
        (index * -150.0),
      );
    });

    _circleAnimations = List.generate(itemCount, (index) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _cardAnimationSecondContoller,
          curve: Curves.easeInOut,
        ),
      );
    });
    //----------tertiary animation----------

    _cardAnimationTertiaryContoller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _cardAnimationTertiary = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardAnimationTertiaryContoller,
        curve: Curves.easeInOut,
      ),
    );

    firtsCardWidget =
        TertaryCardAnimation(cardAnimation: _cardAnimationTertiary)
            .decorator(firtsCardWidget, null);
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
    final textTheme = Theme.of(context).textTheme;
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
                    itemCount,
                    (index) {
                      final initialOffset = _initialOffsets[index];

                      return SecondAnimationCircleWidget(
                        cardAnimation: _circleAnimations[index],
                        initialOffset: initialOffset,
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
              bottom: 150,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  backgroundColor: WidgetStatePropertyAll(Color(0xff00bf86)),
                ),
                onPressed: toggleAnimation,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                  child: Text(
                    "GET THE CARD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: kToolbarHeight,
              left: 16,
              child: Text("Free Debits Card\nZero feeds",
                  style: textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void toggleAnimation() async {
    if (_cardAnimationController.isCompleted) {
      _cardAnimationController.reverse();
      await Future.delayed(const Duration(milliseconds: 500));
      _cardAnimationSecondContoller.forward();
    }
    if ((_cardAnimationSecondContoller.isCompleted)) {
      _cardAnimationSecondContoller.reverse();
      await Future.delayed(const Duration(milliseconds: 500));
      _cardAnimationController.forward();
    }
    print("lucadev state ${_cardAnimationController.status}");
    print("lucadev state ${_cardAnimationSecondContoller.status}");
    // if (!_cardAnimationTertiaryContoller.isCompleted ) {
    //   _cardAnimationTertiaryContoller.forward();
    // }
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
