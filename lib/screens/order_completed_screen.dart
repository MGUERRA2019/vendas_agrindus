import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

class OrderCompletedScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController();
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/animations/longCheck.json',
            width: 70,
            height: 70,
            controller: animationController, onLoaded: (composition) {
          animationController.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          });
          animationController.duration = composition.duration;
          animationController.forward();
        }),
      ),
    );
  }
}
