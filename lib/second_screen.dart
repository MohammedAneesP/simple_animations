import 'package:animations/third_screen.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with TickerProviderStateMixin {
  late Animation<double> progressAnimation;

  late AnimationController anAnimationController;
  late List<Animation<Offset>> slideAnimationList;
  late Animation<Offset> anAnimationOffset;

  @override
  void initState() {
    anAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));

    anAnimationOffset = Tween(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(anAnimationController);

    progressAnimation =
        Tween<double>(begin: 0, end: 0.65).animate(anAnimationController);

    slideAnimationList = List.generate(
      5,
      (index) => Tween(begin: const Offset(-1, 0), end: Offset.zero)
          .animate(CurvedAnimation(
        parent: anAnimationController,
        curve: Interval(index * (1 / 5), 1, curve: Curves.bounceInOut),
      )),
    );

    anAnimationController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimatedBuilder(
              animation: progressAnimation,
              builder: (context, child) => Column(children: [
                Center(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      color: Colors.green,
                      value: progressAnimation.value,
                      strokeWidth: 20,
                    ),
                  ),
                ),
                const SizedBox.square(dimension: 50),
                Center(
                    child: Text(
                  "${(progressAnimation.value * 100).toInt()}",
                  style: const TextStyle(fontSize: 25),
                ))
              ]),
            ),
            const SizedBox.square(dimension: 50),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(animatedRoute());
                },
                child: const Text("NExt Page")),
          ],
        ),
        // child: ListView.builder(
        //   itemBuilder: (context, index) => SlideTransition(
        //     position: slideAnimationList[index],
        //     child: ListTile(
        //       onTap: () {},
        //       title: Text("item number $index"),
        //     ),
        //   ),
        //   itemCount: 5,
        // ),
      ),
    );
  }
}

Route animatedRoute() {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 1000),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const ThirdScreen();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final anTween = Tween(begin: const Offset(0, 1), end: Offset.zero)
          .animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      ));
      final anScale = Tween<double>(begin: .5, end: 1)
          .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
      return FadeTransition(
        opacity: anScale,
        child: child,
      );
      // return SlideTransition(
      //   position: anTween,
      //   child: child,
      // );
    },
  );
}
