import 'dart:math' as math;
import 'package:animations/core/utils/animated_decorator.dart';
import 'package:animations/utils/app_images.dart';
import 'package:flutter/foundation.dart';
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

class SecondAnimationAmountPriceWidget extends AnimatedDecorator {
  final Animation<Offset> cardAnimation;

  final Offset initialOffset;

  SecondAnimationAmountPriceWidget({
    required this.cardAnimation,
    required this.initialOffset,
  });
  @override
  Widget decorator(Widget widgetOne, Widget? widgetTwo) {
    return AnimatedBuilder(
      animation: cardAnimation,
      builder: (BuildContext context, Widget? child) {
        return SlideTransition(
          position: cardAnimation,
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

class QuaternaryCardAnimation extends AnimatedDecorator {
  final Animation cardAnimation;

  QuaternaryCardAnimation({required this.cardAnimation});
  @override
  Widget decorator(Widget widgetOne, Widget? widgetTwo) {
    return AnimatedBuilder(
      animation: cardAnimation,
      builder: (context, child) {
        //firts widget
        final value = cardAnimation.value;
        //second widget
        final valueRotationZ = value * (math.pi * -0.1);
        final valueTranslateX = value * (math.pi * -30);
        final valueTranslateY = value * (math.pi * -15);
        final valueScaleXY = clampDouble((value + 1.0), 1.0, 1.20);
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..translate(valueTranslateX, valueTranslateY, 0.0)
                ..rotateZ(valueRotationZ)
                ..scale(valueScaleXY, valueScaleXY),
              child: widgetTwo,
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..translate(valueTranslateX, 0.0, 0.0)
                ..scale(valueScaleXY, valueScaleXY),

              // ..scale(value, value),
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
  Widget tertiaryCardWidget = CustomCardWidget(
    colorCard: Color(0xff00bf86),
  );

  late AnimationController _cardAnimationController,
      _cardAnimationSecondController,
      _cardAnimationTertiaryController,
      _cardAnimationQuaternayController,
      _amountPrinceController;
  late Animation _cardAnimation,
      _cardAnimationSecond,
      _cardAnimationTertiary,
      _cardAnimationQuaternay;

  late List<Offset> _initialOffsets;
  late List<Animation> _circleAnimations;
  final int itemCount = 10;

  final List<String> listTitle = [
    "Free Debits Card Zero feeds",
    "Instant Access to your Balance",
    "Instant Discounts Every Time",
    "Get Cash at any Atm",
    "Make it your Own",
  ];
  final int countIndicator = 5;

  //-----------amount price--------

  final List<String> amountPrice = [
    "+\$20.00",
    "+\$9999.00",
    "+\$50.00",
    "+\$157.00",
  ];
  late List<Animation<Offset>> _offsetAnimations;
  late List<Offset> _initialAmountOffsets;

  @override
  void initState() {
    _amountPrinceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _initialAmountOffsets = List.generate(amountPrice.length, (index) {
      return Offset(
        (index % 2 == 0) ? -1.0 : 1.0,
        (index % 2 != 0) ? index * -2 : index * 1,
      );
    });
    _offsetAnimations = List.generate(amountPrice.length, (index) {
      return Tween<Offset>(
        begin: Offset.zero,
        end: _initialAmountOffsets[index],
      ).animate(
        CurvedAnimation(
            parent: _amountPrinceController, curve: Curves.easeInOut),
      );
    });

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
      await Future.delayed(const Duration(milliseconds: 400));
      _cardAnimationController.forward();
    });
    //----------firts animation----------
    _cardAnimationSecondController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _cardAnimationSecond = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardAnimationSecondController,
        curve: Curves.easeInOut,
      ),
    );

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
          parent: _cardAnimationSecondController,
          curve: Curves.easeInOut,
        ),
      );
    });
    //----------tertiary animation----------

    _cardAnimationTertiaryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _cardAnimationTertiary = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardAnimationTertiaryController,
        curve: Curves.easeInOut,
      ),
    );
    //----------quaternay animation----------

    _cardAnimationQuaternayController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _cardAnimationQuaternay = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _cardAnimationQuaternayController,
        curve: Curves.easeInOut,
      ),
    );
    super.initState();
  }

  int currentIndex = 0;

  void nextItem() {
    if (currentIndex < listTitle.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void previousItem() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  void dispose() {
    _cardAnimationController.dispose();
    _cardAnimationSecondController.dispose();
    _cardAnimationQuaternayController.dispose();

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
                      final circleAnimations = _circleAnimations[index];
                      return SecondAnimationCircleWidget(
                        cardAnimation: circleAnimations,
                        initialOffset: initialOffset,
                      ).decorator(
                        CircleWidget(
                          index: index,
                          voidCallback: (color) {},
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
              child: Column(
                children: [
                  Row(
                    children: List.generate(countIndicator, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: index == currentIndex
                                ? Colors.white
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(
                            height: 10,
                            width: 10,
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 12),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xff00bf86)),
                    ),
                    onPressed: toggleAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 4),
                      child: Text(
                        "GET THE CARD",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: kToolbarHeight,
              left: 16,
              child: SizedBox(
                height: 100,
                width: size.width,
                child: ListView.builder(
                  itemCount: listTitle.length,
                  itemExtent: size.width,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(1.0, 0.0),
                              end: Offset(0.0, 0.0),
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        listTitle[currentIndex],
                        key: ValueKey<String>(listTitle[currentIndex]),
                        style: textTheme.headlineLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    );
                  },
                ),
              ),
            ),
            ...List.generate(
              amountPrice.length,
              (index) {
                final item = amountPrice[index];
                final initialOffest = _initialAmountOffsets[index];
                final animation = _offsetAnimations[index];
                return Positioned(
                  bottom: 300,
                  child: SecondAnimationAmountPriceWidget(
                    cardAnimation: animation,
                    initialOffset: initialOffest,
                  ).decorator(
                      Text(item,
                          style: textTheme.titleLarge!.copyWith(
                            color: Color(0xff00bf86),
                            fontWeight: FontWeight.bold,
                          )),
                      null),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  AnimationsStatus _currentAnimationStatus = AnimationsStatus.primaryAnimation;

  void toggleAnimation() async {
    nextItem();

    switch (_currentAnimationStatus) {
      case AnimationsStatus.primaryAnimation:
        _cardAnimationController.reverse();
        await Future.delayed(const Duration(milliseconds: 300));
        _amountPrinceController.forward();
        setState(() {
          _currentAnimationStatus = AnimationsStatus.secondayAnimation;
        });
        firtsCardWidget = SecondAnimation(cardAnimation: _cardAnimationSecond)
            .decorator(firtsCardWidget, secondCardWidget);
        break;
      case AnimationsStatus.secondayAnimation:
        _cardAnimationSecondController.forward();
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() {
          _currentAnimationStatus = AnimationsStatus.tertiaryAnimation;
        });
        break;
      case AnimationsStatus.tertiaryAnimation:
        _cardAnimationSecondController.reverse();
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() {
          _currentAnimationStatus = AnimationsStatus.quaternary;
        });
        firtsCardWidget =
            TertaryCardAnimation(cardAnimation: _cardAnimationTertiary)
                .decorator(firtsCardWidget, tertiaryCardWidget);
        _cardAnimationTertiaryController.forward();
        break;
      case AnimationsStatus.quaternary:
        _cardAnimationTertiaryController.reverse();
        await Future.delayed(const Duration(milliseconds: 300));
        setState(() {
          _currentAnimationStatus = AnimationsStatus.fifth;
        });
        firtsCardWidget =
            QuaternaryCardAnimation(cardAnimation: _cardAnimationQuaternay)
                .decorator(firtsCardWidget, secondCardWidget);
        _cardAnimationQuaternayController.forward();
        break;
      case AnimationsStatus.fifth:
        _cardAnimationQuaternayController.reverse();
        break;
    }
  }
}

enum AnimationsStatus {
  primaryAnimation,
  secondayAnimation,
  tertiaryAnimation,
  quaternary,
  fifth
}

class CircleWidget extends StatelessWidget {
  const CircleWidget({super.key, this.index = 1, required this.voidCallback});

  final int index;
  final Function(Color) voidCallback;

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.primaries[index];
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.primaries[index],
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: () => voidCallback(color),
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
    final textTheme = Theme.of(context).textTheme;
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
              top: 54,
              right: 20,
              child: Text(
                "DEBIT",
                style: textTheme.bodyMedium!.copyWith(
                  color: colorCard == Colors.blueGrey
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
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
