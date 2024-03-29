import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

import '/domain/model/character.dart';
import '/domain/model/rarity.dart';
import '/domain/repository/character.dart';
import '/ui/page/home/page/character/view.dart';
import '/util/extensions.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    this.character,
    this.myCharacter,
  });

  final Character? character;
  final RxMyCharacter? myCharacter;

  @override
  Widget build(BuildContext context) {
    Character e = myCharacter?.character.value.character ?? character!;

    return AspectRatio(
      aspectRatio: 0.7,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              e.rarity.color,
              e.rarity.color.darken(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => CharacterView.show(
            context: context,
            myCharacter: myCharacter,
            character: character,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Hero(
                tag: e.id,
                child: Image.asset(
                  'assets/character/${e.asset}.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: Icon(e.role.toIcon(), size: 18, color: Colors.white),
                ),
              ),
              if (myCharacter == null) ...[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const Icon(Icons.lock, color: Colors.white, size: 48),
              ] else ...[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8, right: 16),
                    child: BorderedText(
                      child: Text(
                        'Lv. ${myCharacter!.character.value.level + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
