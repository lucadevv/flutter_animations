import 'dart:ui';
import 'dart:math' as math;
import 'package:animations/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class AnimatioDecorator {
  Widget decorator(Widget widget);
}

class AnimationCardWallet extends AnimatioDecorator {
  final AnimationController controller;

  AnimationCardWallet({required this.controller});
  @override
  Widget decorator(Widget widget) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        double rotationValueX = controller.value * (math.pi * -0.3);
        double translateY = controller.value * -100;
        double rotationValueZ = controller.value * (math.pi * -0.2);
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(0.0, translateY, 0.0)
            ..rotateX(rotationValueX)
            ..rotateZ(rotationValueZ),
          child: widget,
        );
      },
      child: widget,
    );
  }
}

class AnimationCardWalletBack extends AnimatioDecorator {
  final AnimationController controller;

  AnimationCardWalletBack({required this.controller});
  @override
  Widget decorator(Widget widget) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        double rotationValueX = controller.value * (math.pi * -0.3);
        double rotationValueZ = controller.value * (math.pi * -0.2);
        return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(rotationValueX)
              ..rotateZ(rotationValueZ),
            child: widget);
      },
      child: widget,
    );
  }
}

class CardAnimationScreen extends StatefulWidget {
  static const name = 'card-screen';
  const CardAnimationScreen({super.key});

  @override
  State<CardAnimationScreen> createState() => _CardAnimationScreenState();
}

class _CardAnimationScreenState extends State<CardAnimationScreen>
    with SingleTickerProviderStateMixin {
  Widget cardChildWidget = CardWidgetWalletFront();
  Widget cardChildWidgetBack = CardWidgetWalletBack();
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    cardChildWidget =
        AnimationCardWallet(controller: _controller).decorator(cardChildWidget);
    cardChildWidgetBack = AnimationCardWalletBack(controller: _controller)
        .decorator(cardChildWidgetBack);

    super.initState();
  }

  void toggleAnimation() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFede4c7),
      body: Stack(
        children: [
          Positioned(
            top: -140,
            left: -140,
            child: _circleShapeBlur(Color(0XFFede4c7)),
          ),
          Positioned(
            top: -100,
            right: -200,
            child: _circleShapeBlur(Color(0xff4a3fe0)),
          ),
          Positioned(
            bottom: -140,
            left: -140,
            child: _circleShapeBlur(Color(0XFFc24675)),
          ),
          Positioned(
            bottom: -140,
            right: -140,
            child: _circleShapeBlur(Color(0XFFbf584b)),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: cardChildWidgetBack,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: toggleAnimation,
              hoverColor: Colors.transparent,
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: cardChildWidget,
              ),
            ),
          ),
          // Positioned(
          //   bottom: 24,
          //   left: 0,
          //   right: 0,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       TextButton(
          //         onPressed: toggleAnimation,
          //         child: Text(
          //           "Animated",
          //           style: TextStyle(
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //       TextButton(
          //         onPressed: () {
          //           _controller.reset();
          //         },
          //         child: Text(
          //           "reset",
          //           style: TextStyle(
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _circleShapeBlur(Color color) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 120,
            spreadRadius: 250,
          ),
        ],
      ),
      child: SizedBox(
        height: 200,
        width: 200,
      ),
    );
  }
}

class CardWidgetWalletFront extends StatelessWidget {
  const CardWidgetWalletFront({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: SizedBox(
        height: 240,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              right: 16,
              child: SvgPicture.asset(
                AppImages.visaSvg,
                height: 40,
                width: 40,
              ),
            ),
            Positioned(
              top: 24,
              right: 16,
              child: SvgPicture.asset(
                AppImages.mastercardSvg,
                height: 60,
                width: 40,
              ),
            ),
            Positioned(
              top: 24,
              left: 16,
              child: SvgPicture.asset(
                AppImages.simcardSvg,
                height: 60,
                width: 40,
              ),
            ),
            Positioned(
              bottom: 24,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lucadevv",
                    style: textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "github.com/lucadevv",
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'VENCE\nFIN DE  ',
                    style: textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                      fontSize: 8,
                      height: 1,
                    ),
                  ),
                  Text('08/32'),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "5234  2345  5432 5324",
                  style: textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidgetWalletBack extends StatelessWidget {
  const CardWidgetWalletBack({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: SizedBox(
        height: 240,
        width: double.infinity,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            Positioned(
              top: 24,
              left: 0,
              right: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: Text(
                textBackCard,
                style: textTheme.labelSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey,
                  fontSize: 9,
                  height: 1,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1.0, 0.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      AppImages.worldSvg,
                      height: 40,
                      width: 40,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white60,
                      ),
                      child: SizedBox(
                        height: 50,
                        width: 100,
                        child: Center(
                          child: Text(
                            "078",
                            style: textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.blueGrey,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final textBackCard =
    'Esta tarjeta fue creada por Luis Carranza Sadaña, Mobile Developer de Perú. El diseño original fue inspirado en el trabajo Multi-layered 3D card animation in Figma, creado por Sami alhattab y disponible en Dribbble. Puedes encontrar el diseño original en el siguiente enlace: https://dribbble.com/shots/25348217-Multi-layered-3D-card-animation-in-Figma. Agradezco al diseñador por la inspiración y por compartir su increíble trabajo con la comunidad.';
