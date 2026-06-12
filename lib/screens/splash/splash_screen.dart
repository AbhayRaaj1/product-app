import 'dart:async';

import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  late Animation<double> scaleAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );

    scaleAnimation = Tween<double>(
      begin: 0.6,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );

    controller.forward();

    Timer(
      const Duration(seconds: 3),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
            const HomeScreen(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [
              Color(0xff0f0f0f),
              Color(0xff1a1a1a),
              Color(0xff252525),
            ],
          ),
        ),

        child: Center(

          child: FadeTransition(

            opacity: opacityAnimation,

            child: ScaleTransition(

              scale: scaleAnimation,

              child: Column(

                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Image.asset(
                    "assets/images/logo.png",
                    width: 220,
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  const Text(

                    "ShopSphere",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight:
                      FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(

                    "Premium Shopping Experience",

                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  const CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}