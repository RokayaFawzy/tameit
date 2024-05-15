import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tame_it/values/values.dart';

class BubbleBackground extends StatefulWidget {
  @override
  _BubbleBackgroundState createState() => _BubbleBackgroundState();
}

class _BubbleBackgroundState extends State<BubbleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Bubble> _bubbles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    )..repeat();
    for (int i = 0; i < 20; i++) {
      _bubbles.add(Bubble());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        _updateBubbles();
        return CustomPaint(
          painter: BubblePainter(_bubbles),
        );
      },
    );
  }

  void _updateBubbles() {
    for (Bubble bubble in _bubbles) {
      bubble.update();
    }
  }
}

class Bubble {
  double x;
  double y;
  double radius;
  double dx;
  double dy;
  final Color color;

  Bubble()
      : x = Random().nextDouble(),
        y = Random().nextDouble(),
        radius = Random().nextDouble() * 20 + 10,
        dx = Random().nextDouble() * 0.01 - 0.005,
        dy = Random().nextDouble() * 0.01 - 0.005,
        color = AppColors.deepsea.withOpacity(Random().nextDouble());

  void update() {
    x += dx;
    y += dy;

    if (x < 0 || x > 1) dx = -dx;
    if (y < 0 || y > 1) dy = -dy;
  }
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;

  BubblePainter(this.bubbles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (Bubble bubble in bubbles) {
      paint.color = bubble.color;
      canvas.drawCircle(
        Offset(bubble.x * size.width, bubble.y * size.height),
        bubble.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
