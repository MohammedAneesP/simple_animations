import 'package:animations/second_screen.dart';
import 'package:flutter/material.dart';

class AnimatedScreen extends StatefulWidget {
  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen>
    with TickerProviderStateMixin {

  late Animation<double> logoFadeAnimation;
  late Animation<Color> colorAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slidingAnimation;

  late AnimationController anAnimationController;

  @override
  void initState() {
    anAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );

    scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: anAnimationController, curve: Curves.bounceInOut));

    slidingAnimation = Tween(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: anAnimationController, curve: Curves.bounceOut));

    logoFadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(anAnimationController);

    anAnimationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "heroFlutter",
              child: FadeTransition(
                opacity: logoFadeAnimation,
                child: const FlutterLogo(
                  size: 150,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SlideTransition(
              position: slidingAnimation,
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ScaleTransition(
              scale: scaleAnimation,
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SecondScreen(),
                    ),
                  );
                },
                child: const Text("submit"))
          ],
        ),
      ),
    );
  }
}
