import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:tryout_game_maikel/collect_money/main.dart';

class Moneybank extends SpriteComponent
    with HasGameRef<CollectMoneyGame>, CollisionCallbacks {
  late ShapeHitbox hitbox;
  bool flipped = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('player-sprite.png',
        srcPosition: Vector2(200, 480), srcSize: Vector2(1000, 700));

    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 75);
    width = 1000 / 6;
    height = 700 / 6;
    anchor = Anchor.center;

    hitbox = CircleHitbox()
      ..renderShape = false;
    add(hitbox);
  }

  void move(Vector2 delta) {
    delta.y = 0;

    position.add(delta);

    if (position.x < 100) position.x = 100;

    if (position.x > gameRef.size.x - (700 / 6))
      position.x = gameRef.size.x - (700 / 6);

    if(delta.x < 0 && !flipped){
      flipHorizontally();
      flipped = true;
    }
    if(delta.x >= 0 && flipped){
      flipHorizontally();
      flipped = false;
    }
  }
}
