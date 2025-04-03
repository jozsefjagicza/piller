
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:piller/common/widgets/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {

    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        body: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.1, end: 2.0),
            duration: const Duration(seconds: 2),
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Image.asset('assets/images/logo.png', width: 100, height: 100),
          ),
        ),
      ),
    );
  }
}
