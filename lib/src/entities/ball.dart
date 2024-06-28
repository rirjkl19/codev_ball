import 'dart:async';
import 'dart:math';

import 'package:codev_ball/src/ball_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends PositionComponent with HasGameRef<BallGame> {
  Ball({required this.initialPosition});

  final Vector2 initialPosition;
  final radius = 10.0;

  @override
  FutureOr<void> onLoad() {
    position = initialPosition;
    anchor = Anchor.center;
    size = Vector2.all(radius);
    final paint = Paint()..color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    final circle = CircleComponent(radius: radius, paint: paint);
    add(circle);
  }
}
