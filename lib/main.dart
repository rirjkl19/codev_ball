import 'package:codev_ball/src/ball_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: BallGame(),
      overlayBuilderMap: {
        'debug': (context, game) {
          return Container(
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.5),
            child: const Text(
              'Debug text',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      },
    ),
  );
}
