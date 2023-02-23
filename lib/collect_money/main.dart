import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'package:flutter/material.dart';

import 'package:tryout_game_maikel/collect_money/background.dart';
import 'package:tryout_game_maikel/collect_money/coin.dart';
import 'package:tryout_game_maikel/collect_money/player.dart';

void main() {
  runApp(GameWidget(game: CollectMoneyGame()));
}

class CollectMoneyGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Moneybank moneybank;
  late List<Coin> coins;
  late TextComponent moneyStatus;
  late Background background;

  int frameCounter = 0;
  int moneyCollected = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    moneybank = Moneybank();
    background = Background();
    coins = [];

    moneyStatus = TextComponent(text: moneyCollected.toString())
      ..anchor = Anchor.topCenter
      ..x = size.x - 150 // size is a property from game
      ..y = 32.0;

    add(background);
    add(moneybank);
    add(moneyStatus);

    add(
      TextComponent(text: 'Coins: ')
        ..anchor = Anchor.topCenter
        ..x = size.x - 200 // size is a property from game
        ..y = 32.0,
    );
  }

  void createCoin() {
    final coin = Coin();
    coins.add(coin);
    add(coin);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    moneybank.move(info.delta.game);
  }

  @override
  void update(double dt) {
    super.update(dt);

    frameCounter++;
    if (frameCounter > 200) {
      createCoin();
      frameCounter = 0;
    }
  }

  void redeemCoin(Coin coin) {
    moneyCollected++;
    moneyStatus.text = moneyCollected.toString();
    remove(coin);
  }
}
