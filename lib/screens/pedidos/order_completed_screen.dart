import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

//Tela para mostrar ao usuário que o pedido foi efetuado com sucesso com animação Lottie

class OrderCompletedScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController();
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/animations/done.json',
            width: 200,
            height: 200,
            controller: animationController, onLoaded: (composition) {
          animationController.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              sleep(Duration(milliseconds: 900));
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
