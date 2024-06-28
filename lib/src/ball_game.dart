import 'package:codev_ball/src/entities/ball.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class BallGame extends FlameGame with TapDetector, HasCollisionDetection {
  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    final ball = Ball(initialPosition: info.eventPosition.global);
    add(ball);
  }
}
