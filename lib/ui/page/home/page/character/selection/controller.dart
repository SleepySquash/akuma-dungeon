import 'package:akuma/domain/model/character.dart';
import 'package:akuma/domain/model/character/standard.dart';
import 'package:akuma/domain/service/character.dart';
import 'package:akuma/domain/service/player.dart';
import 'package:get/get.dart';

class CharacterSelectionController extends GetxController {
  CharacterSelectionController(
    this._characterService,
    this._playerService,
  );

  final Rx<Character?> selected = Rx(null);
  final List<Character> characters = const [Rozzi(), DrNadja(), Rio()];

  final CharacterService _characterService;
  final PlayerService _playerService;

  void select() {
    if (selected.value != null) {
      MyCharacter character = _characterService.add(selected.value!);
      print(character);
      _playerService.addToParty(character);
      print(_playerService.player.party.length);
    }
  }
}
