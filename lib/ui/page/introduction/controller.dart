// Copyright © 2022 NIKITA ISAENKO, <https://github.com/SleepySquash>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License v3.0 as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License v3.0 for
// more details.
//
// You should have received a copy of the GNU Affero General Public License v3.0
// along with this program. If not, see
// <https://www.gnu.org/licenses/agpl-3.0.html>.

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart' show TextEditingController;
import 'package:get/get.dart';
import 'package:novel/novel.dart';

import '/domain/model/gender.dart';
import '/domain/model/player.dart';
import '/domain/model/race.dart';
import '/domain/service/auth.dart';
import '/router.dart';

enum IntroductionStage {
  novel,
  character,
  name,
}

class IntroductionController extends GetxController {
  IntroductionController(this._authService);

  final Rx<IntroductionStage> stage = Rx(IntroductionStage.novel);

  final RxBool nameIsEmpty = RxBool(true);
  final TextEditingController name = TextEditingController();

  final Rx<Gender> gender = Rx(Gender.male);
  final Rx<Race> race = Rx(Race.ningen);

  final AuthService _authService;
  final AudioPlayer _player = AudioPlayer(playerId: 'introduction');

  @override
  void onReady() {
    _player.play(
      AssetSource('music/MOSAICWAV_she_already_gone.mp3'),
      volume: 0.4,
    );
    _player.setReleaseMode(ReleaseMode.loop);

    _novel();

    super.onReady();
  }

  void accept() {
    if (name.text.isNotEmpty) {
      stage.value = IntroductionStage.novel;
      _introduction();
    }
  }

  Future<void> _register() async {
    await _authService.register();
    _player.stop();
    _player.release();
    router.home(
      player: Player(
        name: name.text,
        race: race.value,
        gender: gender.value,
      ),
    );
  }

  Future<void> _novel() async {
    await Future.delayed(200.milliseconds);
    await Novel.show(
      context: router.context!,
      scenario: [
        BackgroundLine('location/guild.jpg'),
        CharacterLine('arda.png'),
        DialogueLine(
          'Добрый день!',
          by: 'Мастер',
          voice: 'intro/1.mp3',
        ),
        DialogueLine(
          'Добро пожаловать в гильдию путешественников города Алоросс!',
          by: 'Мастер',
          voice: 'intro/2.m4a',
        ),
        DialogueLine(
          'Итак, ты хочешь вступить в ряды путешественников?',
          by: 'Мастер',
          voice: 'intro/3.mp3',
        ),
        DialogueLine(
          'Что-ж, меня зовут Никита.',
          by: 'Мастер',
          voice: 'intro/4.mp3',
        ),
        DialogueLine(
          'Я временно заменяю гильдмастера, она... будет позже.',
          by: 'Мастер',
          voice: 'intro/5.m4a',
        ),
        DialogueLine(
          'Наш Алоросс - городок небольшой, но поручений тут не меньше, чем в каком-нибудь крупном граде.',
          by: 'Мастер',
          voice: 'intro/6.m4a',
        ),
        DialogueLine(
          'Тебя ждут приключения, слава и гарем эльфиечек, кхм, но не факт.',
          by: 'Мастер',
          voice: 'intro/7.m4a',
        ),
        DialogueLine(
          'Ну, успеешь со всем познакомиться позже, а пока заполни, пожалуйста, вот эту анкету.',
          by: 'Мастер',
          voice: 'intro/8.m4a',
        ),
      ],
    );
    await Future.delayed(200.milliseconds);

    stage.value = IntroductionStage.character;
  }

  Future<void> _introduction() async {
    await Future.delayed(200.milliseconds);
    await Novel.show(
      context: router.context!,
      scenario: [
        BackgroundLine('location/guild.jpg'),
        CharacterLine('arda.png'),
        DialogueLine(
          'Всё отлично, благодарю за анкетку.',
          by: 'Мастер',
          voice: 'intro/31.m4a',
        ),
        DialogueLine(
          'Дай мне пару минут...',
          by: 'Мастер',
          voice: 'intro/32.m4a',
        ),
        HideCharacterLine('arda.png'),
        DialogueLine(
          'Ты ждёшь пару минут, пока гильдмастер заполняет бумаги.',
        ),
        DialogueLine(
          'Несмотря на удалённость от центра, городок вполне себе технологичный.',
        ),
        DialogueLine(
          'Гильдмастер достаёт ноутбук, на котором увлечённо что-то делает около минуты.',
        ),
        CharacterLine('arda.png'),
        DialogueLine(
          'Готово!',
          by: 'Мастер',
          voice: 'intro/9.m4a',
        ),
        DialogueLine(
          'Ну что, поздравляю, теперь ты настоящий путешественник!',
          by: 'Мастер',
          voice: 'intro/10.m4a',
        ),
        DialogueLine(
          'Твой ранг, как и у всех начинающих, D!',
          by: 'Мастер',
          voice: 'intro/11.m4a',
        ),
        DialogueLine(
          'Но ты буквально в шаге от получения SSS титула, я прям вижу по тебе.',
          by: 'Мастер',
          voice: 'intro/12.m4a',
        ),
        DialogueLine(
          'Приходи в гильдию, чтобы брать поручения и задания по закрытию данжей.',
          by: 'Мастер',
          voice: 'intro/13.m4a',
        ),
        DialogueLine(
          'У каждого поручения своя сложность, но и своя награда.',
          by: 'Мастер',
          voice: 'intro/14.m4a',
        ),
        DialogueLine(
          'Помни, что в твоих приключениях немаловажную роль играют твои навыки, экипировка и класс.',
          by: 'Мастер',
          voice: 'intro/15.m4a',
        ),
        DialogueLine(
          'И не забывай, что иногда важно полагаться на свою пати.',
          by: 'Мастер',
          voice: 'intro/16.m4a',
        ),
        DialogueLine(
          'Она будет прикрывать твою спину, брать на себя урон или, наоборот, наносить его.',
          by: 'Мастер',
          voice: 'intro/17.m4a',
        ),
        DialogueLine(
          'Пойдём покажу тебе твои апартаменты.',
          by: 'Мастер',
          voice: 'intro/18.m4a',
        ),
        HideCharacterLine('arda.png'),
        BackgroundLine('location/town.jpg'),
        DialogueLine(
          'Пока вы идёте, ты замечаешь вокруг множество незнакомых взглядов на себе.',
        ),
        DialogueLine(
          'Некоторые из них улыбаются и машут тебе, ты неловко машешь в ответ.',
        ),
        DialogueLine(
          '...хотя, возможно, они приветствовали и не тебя, а гильдмастера, но эти мысли пришли уже позже.',
        ),
        BackgroundLine('room/renovation.jpg'),
        CharacterLine('arda.png'),
        DialogueLine(
          'Н-да, удачи тебе тут жить, конечно!',
          by: 'Мастер',
          voice: 'intro/19.m4a',
        ),
        DialogueLine(
          'Ой, то есть, это единственное, к сожалению, что наш городок сейчас может предоставить.',
          by: 'Мастер',
          voice: 'intro/20.m4a',
        ),
        DialogueLine(
          'Из-за постоянно открывающихся данжей и отсутствия лишних рук, чтобы с ними сражаться преждевременно...',
          by: 'Мастер',
          voice: 'intro/21.m4a',
        ),
        DialogueLine(
          '...у нас, как ты видишь, проблемы и с жильём, и с продовольствием, и не только.',
          by: 'Мастер',
          voice: 'intro/22.m4a',
        ),
        DialogueLine(
          'Когда открывается данж, у нас есть около нескольких дней, чтобы успеть его закрыть.',
          by: 'Мастер',
          voice: 'intro/23.m4a',
        ),
        DialogueLine(
          'Иначе из данжа выходят монстры и атакуют население.',
          by: 'Мастер',
          voice: 'intro/24.m4a',
        ),
        DialogueLine(
          'Стража справляется с теми, кто подходит близко к границам города.',
          by: 'Мастер',
          voice: 'intro/25.m4a',
        ),
        DialogueLine(
          'Но за их пределами торговцы, молодёжь и путешественники становятся...',
          by: 'Мастер',
          voice: 'intro/26.m4a',
        ),
        DialogueLine(
          'Кхм, путешественник! Я имел в виду, успевают сбежать и спастись в нашем городе, конечно же!',
          by: 'Мастер',
          voice: 'intro/27.m4a',
        ),
        DialogueLine(
          'Ну, вообще, так и есть, это я троллю тебя так, это была сверх-мета-пост-ирония.',
          by: 'Мастер',
          voice: 'intro/28.m4a',
        ),
        DialogueLine(
          'Обустраивайся тут, знакомься с окружением.',
          by: 'Мастер',
          voice: 'intro/29.m4a',
        ),
        DialogueLine(
          'Когда будешь готов, я жду тебя в гильдии.',
          by: 'Мастер',
          voice: 'intro/30.m4a',
        ),
        HideCharacterLine('arda.png')
      ],
    );
    await Future.delayed(200.milliseconds);

    _register();
  }
}
