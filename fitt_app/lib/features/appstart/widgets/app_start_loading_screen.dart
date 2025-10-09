import 'dart:math' as math;
import 'package:flutter/material.dart';

class AppStartLoadingScreen extends StatefulWidget {
  const AppStartLoadingScreen({super.key});

  @override
  State<AppStartLoadingScreen> createState() => _AppStartLoadingScreenState();
}

class _AppStartLoadingScreenState extends State<AppStartLoadingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              final animationValue = Curves.easeInOut.transform(_controller.value);
              return Transform.rotate(
                angle: (animationValue - 0.5) * (math.pi / 3.6),
                child: child,
              );
            },
            child: const Icon(
              Icons.fitness_center,
              size: 80.0,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Fitt App',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none, // Eltávolítja a sárga aláhúzást
            ),
          ),
        ],
      ),
    );
  }
}