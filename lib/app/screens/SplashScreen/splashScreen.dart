import 'package:flutter/material.dart';
import '/app/imports/all_imports.dart';

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation}) : super(listenable: animation);

  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 250);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Opacity(
            opacity: _opacityTween.evaluate(animation),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: _sizeTween.evaluate(animation),
              width: _sizeTween.evaluate(animation),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/images/...Loading.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Проект Marta-NG',
          style: TextStyle(
            fontFamily: FontFamily.semiFont,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'представляет',
          style: TextStyle(
            fontFamily: FontFamily.extraboldFont,
            fontSize: 32,
          ),
        ),
      ],
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOutQuad);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
