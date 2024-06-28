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

  late Vector2 direction = (Vector2.random() - Vector2.random()).normalized() * speed;

  @override
  FutureOr<void> onLoad() {
    print('Ball loaded $hashCode');
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
    super.update(dt);
    position += direction * dt;
    _removeOnScreenEdge();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ball) {
      print('Collision between $hashCode and ${other.hashCode}');
      removeFromParent();
      other.removeFromParent();
    }
    return super.onCollision(intersectionPoints, other);
  }

  @override
  void onRemove() {
    print('Ball removed $hashCode');
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
