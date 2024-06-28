import 'dart:async';
import 'dart:math';

import 'package:codev_ball/src/ball_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends PositionComponent with HasGameRef<BallGame>, CollisionCallbacks {
  Ball({required this.initialPosition});

  final Vector2 initialPosition;
  final radius = 10.0;
  final speed = 50.0;

  late Vector2 velocity = Vector2.random() * speed;

  @override
  FutureOr<void> onLoad() {
    debugPrint('Ball loaded $hashCode');
    position = initialPosition;
    anchor = Anchor.center;
    size = Vector2.all(radius);
    add(CircleHitbox(radius: radius));

    final paint = Paint()..color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    final circle = CircleComponent(radius: radius, paint: paint);
    add(circle);
  }

  @override
  void update(double dt) {
    position += velocity * dt;
    _removeOnScreenEdge();
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ball) {
      final newDirection = (position - other.position).normalized();
      velocity = newDirection * speed;
      other.velocity = -newDirection * speed;
    }
  }

  @override
  void onRemove() {
    debugPrint('Ball removed $hashCode');
    super.onRemove();
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
