import 'package:flutter/material.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen>
    with TickerProviderStateMixin {
  late Animation<double> anAnimatedIcon;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration:const Duration(milliseconds: 1500));
    anAnimatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Third Page"),
      ),
      body: Center(
          child: AnimatedIcon(
        icon: AnimatedIcons.search_ellipsis,
        progress: anAnimatedIcon,
        size: 50,
      )),
    );
  }
}
