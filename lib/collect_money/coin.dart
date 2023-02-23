import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:tryout_game_maikel/collect_money/main.dart';
import 'package:tryout_game_maikel/collect_money/player.dart';

class Coin extends SpriteComponent
    with HasGameRef<CollectMoneyGame>, CollisionCallbacks {
  late ShapeHitbox hitbox;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('coin.png');

    final rnd = Random();
    final max = (gameRef.size.x - 300).round();
    position = Vector2(rnd.nextInt(max).toDouble(), -50);
    width = 50;
    height = 50;

    hitbox = CircleHitbox()
      ..renderShape = false;
    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y = position.y + 3;

    if (position.y > gameRef.size.y) position.y = gameRef.size.y;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    // hitbox.paint.color = _collisionColor;
    if (other is Moneybank) {
      game.redeemCoin(this);
      return;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (!isColliding) {
      // hitbox.paint.color = _defaultColor;
    }
  }
}