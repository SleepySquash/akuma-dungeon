import 'dart:math';

import 'package:akuma/domain/model/character.dart';
import 'package:akuma/domain/model/character/all.dart';
import 'package:akuma/domain/model/item.dart';
import 'package:akuma/domain/model/item/all.dart';
import 'package:akuma/domain/model/rarity.dart';
import 'package:akuma/util/message_popup.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:log_me/log_me.dart';

import '/domain/service/character.dart';
import '/domain/service/item.dart';

enum GachaType {
  character,
  weapon,
}

class GachaService extends DisposableInterface {
  GachaService(this._itemService, this._characterService);

  final ItemService _itemService;
  final CharacterService _characterService;

  List<dynamic> get({
    int amount = 1,
    GachaType type = GachaType.character,
  }) {
    final List<dynamic> loot = [];

    Random random = Random();
    for (var i = 0; i < amount; ++i) {
      int p = random.nextInt(1000000);

      dynamic reward;

      // 1 in 10000.
      if (p < 100) {
        Future.delayed(
          Duration.zero,
          () => MessagePopup.alert('Нихуя ты баклажан, вероятность 1 к 10000'),
        );
      }

      // 1 in 1000.
      else if (p < 1000) {
        reward = _randomReward(type: type, rarity: Rarity.ultraRare);
      }

      // 1 in 100.
      else if (p < 10000) {
        reward = _randomReward(type: type, rarity: Rarity.superRare);
      }

      // 1 in 10.
      else if (p < 100000) {
        reward = _randomReward(type: type, rarity: Rarity.rare);
      }

      // 2 in 10.
      else if (p < 300000) {
        reward = _randomReward(type: type, rarity: Rarity.useful);
      }

      // 7 in 10.
      else {
        reward = [
          ...Items.weapon,
          ...Items.equipable,
        ].sample(1).first;
      }

      if (reward is Character) {
        loot.add(reward);
        _characterService.add(reward);
        Log.debug('ROLLED [Character] ${reward.name}, ${reward.rarity}');
      } else if (reward is Item) {
        loot.add(reward);
        _itemService.add(reward);
        Log.debug('ROLLED [Item] ${reward.name}, ${reward.rarity}');
      } else {
        Log.debug('Rolled nothing :(');
      }
    }

    return loot;
  }

  dynamic _randomReward({
    GachaType type = GachaType.character,
    Rarity rarity = Rarity.rare,
  }) {
    if (type == GachaType.character) {
      return Characters.all
          .where((e) => e.rarity == rarity)
          .sample(1)
          .firstOrNull;
    } else {
      return Items.weapon
          .where((e) => e.rarity == rarity)
          .sample(1)
          .firstOrNull;
    }
  }
}
