import 'dart:async';
import 'dart:math';

import 'package:codev_ball/src/ball_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends PositionComponent with HasGameRef<BallGame> {
  Ball({required this.initialPosition});

  final Vector2 initialPosition;
  final radius = 10.0;
  final speed = 50.0;

  late final direction = (Vector2.random() - Vector2.random()).normalized() * speed;

  @override
  FutureOr<void> onLoad() {
    print('Ball loaded $hashCode');
    position = initialPosition;
    anchor = Anchor.center;
    size = Vector2.all(radius);
    final paint = Paint()..color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    final circle = CircleComponent(radius: radius, paint: paint);
    add(circle);
  }

  @override
  void onRemove() {
    print('Ball removed $hashCode');
    super.onRemove();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += direction * dt;
    _removeOnScreenEdge();
  }

  // Remove ball if it moves off screen
  void _removeOnScreenEdge() {
    if (position.x < -radius ||
        position.x > gameRef.size.x + radius ||
        position.y < -radius ||
        position.y > gameRef.size.y + radius) {
      removeFromParent();
    }
  }
}
