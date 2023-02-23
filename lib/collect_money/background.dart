import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:tryout_game_maikel/collect_money/main.dart';

class Background extends SpriteComponent with HasGameRef<CollectMoneyGame> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('background.jpg');
    setAlpha(50);
    width = gameRef.size.x;
    height = gameRef.size.y;
  }

  @override
  void update(double dt) {
    width = gameRef.size.x;
    height = gameRef.size.y;
  }
}
