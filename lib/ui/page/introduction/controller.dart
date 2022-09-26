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
  final AudioPlayer _player = AudioPlayer();

  @override
  Future<void> onReady() async {
    // if (kDebugMode) {
    //   name.text = 'Test';
    //   race.value = Race.usagi;
    //   gender.value = Gender.female;
    //   _register();
    // } else {
    // await _player.setLoopMode(LoopMode.one);
    // await _player.setVolume(0.4);
    // await _player.setAsset('music/MOSAICWAV_she_already_gone.mp3');
    // _player.play();

    _novel();
    // }

    super.onReady();
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }

  void accept() {
    if (name.text.isNotEmpty) {
      stage.value = IntroductionStage.novel;
      _introduction();
    }
  }

  Future<void> _register() async {
    await _authService.register();
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
        const MusicLine('mixkit-lost-in-dreams-26.mp3'),
        BackgroundLine('location/mediterranean_town.jpg'),
        DialogueLine(
            'Ты хватаешься за голову, осматриваешь себя на предмет каких-либо травм.'),
        DialogueLine('Так, а откуда они должны были взяться?'),
        DialogueLine('Где ты?'),
        DialogueLine(
            'Мгновением позже ты понимаешь, что ты не можешь ответить даже на более примитивный вопрос: кто ты?'),
        DialogueLine(
            'Осмотревшись, ты понимаешь, что стоишь у дороги, отсюда открывается вид на какой-то город.'),
        DialogueLine('На спине рюкзак, в карманах деньги и... телефон!'),
        DialogueLine(
            'Ты судорожно достаёшь свой телефон из кармана, пароля нет, разблокируешь его.'),
        DialogueLine('Симка есть, Интернет ловит, отлично.'),
        DialogueLine(
            'Ты открываешь галерею - пусто, смотришь контакты - пусто.'),
        DialogueLine(
            'Ты недоволен собой за то, что не оставил никаких заметок себе на случай таких ситуаций, кем бы ты ни был.'),
        DialogueLine(
            'Наконец, в заметках ты находишь единственную: в ней листовка с рекламой гильдии путешественников города Алоросс.'),
        DialogueLine(
            'Зацепка? Едва ли. Ты открываешь историю браузера, но в ней только простые запросы.'),
        DialogueLine(
            '"Лесбийский хентай с эльфиечками и кошкодевочками", "Порно с дворфами смешное", "Алоросс".'),
        DialogueLine('Видимо, ты был человеком культуры.'),
        DialogueLine('Но почему ты ничего не помнишь?'),
        DialogueLine(
            'Погода стояла дикая, солнце палило твою голову - стал ли солнечный удар причиной отшиба?'),
        DialogueLine(
            'Вокруг никого, ты решаешь идти вперёд в город перед тобой.'),
        DialogueLine(
            'По пути ты безуспешно пытаешься связать имеющуюся у тебя информацию в клубок, чтобы распутать его.'),
        DialogueLine(
            'Современность, какой ты её знаешь, состоит из передовых технологий - телефоны, компьютеры, космос.'),
        DialogueLine(
            'Около пятисот лет назад появились подземелья или данжи - порталы в измерение монстров.'),
        DialogueLine(
            'С тех пор человечество тратит огромное количество усилий на борьбу с монстрами.'),
        DialogueLine(
            'Но жизнь продолжается. Кроме того, вышедшие из данжей более слабые расы спокойно прижились в нашем измерении.'),
        DialogueLine(
            'Кроме людей, наш мир обитаем дварфами, эльфами, всеми типами ушастых, вампирами.'),
        DialogueLine(
            'Изначально, конечно, люди объявили этим расам войну - так началась Священная Война на религиозной почве.'),
        DialogueLine(
            'К счастью, довольно скоро эта война кончилась и теперь люди сосуществуют с существами из измерения Акумы.'),
        DialogueLine(
            'Акума - это титул, который присваивается сильнейшему дьяволу, что управляет монстрами.'),
        DialogueLine(
            'Судя по рассказам ушастых, в измерении Акумы лютая тирания, поэтому многие нашли мир в наших землях.'),
        BackgroundLine('location/town.jpg'),
        DialogueLine('"Алоросс" - вывеска у врат на входе.'),
        DialogueLine(
            'Возможно, твои заметки всё-таки связаны с разгадкой этой ситуации.'),
        DialogueLine(
            'Ты решаешь обойти город, чтобы триггернуть какие-либо воспоминания.'),
        DialogueLine('Но к твоему сожалению никто тебя не узнаёт.'),
        DialogueLine(
            'Не имея альтернатив, ты отправляешься в гильдию путешественников.'),
        DialogueLine(
            'В конце концов, именно она является твоей единственной зацепкой.'),
        BackgroundLine('location/guild.jpg'),
        CharacterLine('Arda.png'),
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
          'Я временно заменяю гильдмастера, она... будет позже.',
          by: 'Мастер',
          voice: 'intro/5.m4a',
        ),
        DialogueLine('Ты объясняешь ситуацию гильдмастеру.'),
        DialogueLine(
          'Ага, понятно. К сожалению, я тоже вижу тебя впервые.',
          by: 'Мастер',
        ),
        DialogueLine(
          'Но у меня есть идея - ты можешь стать путешественником.',
          by: 'Мастер',
        ),
        DialogueLine(
          'Выполняя поручения, ты постоянно будешь путешествовать и тем самым обязательно найдёшь кого-нибудь, кто тебя помнит.',
          by: 'Мастер',
        ),
        DialogueLine(
          'Маловероятно, что ты потерял память внезапно тут и здесь, что-то должно связывать тебя с Алороссом.',
          by: 'Мастер',
        ),
        DialogueLine('У тебя нет ни малейшей идеи, куда идти и куда податься.'),
        DialogueLine(
            'Наличных в твоём кармане надолго не хватит, а путешествовия действительно могут тебе помочь.'),
        DialogueLine('Ты соглашаешься.'),
        DialogueLine(
            'Твоя цель - найти себя, путешествуя по миру, тебе больше ничего не остаётся.'),
        DialogueLine(
          'Итак, ты хочешь вступить в ряды путешественников?',
          by: 'Мастер',
          voice: 'intro/3.mp3',
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

    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setVolume(0.4);
    _player.play(AssetSource('music/MOSAICWAV_she_already_gone.mp3'));

    stage.value = IntroductionStage.character;
  }

  Future<void> _introduction() async {
    await Future.delayed(200.milliseconds);
    await Novel.show(
      context: router.context!,
      scenario: [
        BackgroundLine('location/guild.jpg'),
        CharacterLine('Arda.png'),
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
        HideCharacterLine('Arda.png'),
        DialogueLine('Ты ждёшь пару минут, пока гильдмастер заполняет бумаги.'),
        DialogueLine(
            'Гильдмастер достаёт ноутбук, на котором увлечённо что-то делает около минуты.'),
        CharacterLine('Arda.png'),
        DialogueLine('Готово!', by: 'Мастер', voice: 'intro/9.m4a'),
        DialogueLine(
          'Ну что, поздравляю, теперь ты настоящий путешественник!',
          by: 'Мастер',
          voice: 'intro/10.m4a',
        ),
        DialogueLine('Твой ранг, как и у всех начинающих, F!', by: 'Мастер'),
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
          'По поводу того, где тебе остановиться, есть одна идея.',
          by: 'Мастер',
        ),
        DialogueLine(
          'Гильдия владеет имуществом, которое город даёт ей для временного размещения путешественников в случае экстренной ситуации.',
          by: 'Мастер',
        ),
        DialogueLine(
          'Я готов предоставить тебе свободную квартирку, но признаюсь сразу: состояние у неё не ахти.',
          by: 'Мастер',
        ),
        DialogueLine(
          'Пойдём покажу тебе твои апартаменты.',
          by: 'Мастер',
          voice: 'intro/18.m4a',
        ),
        HideCharacterLine('Arda.png'),
        BackgroundLine('location/town.jpg'),
        DialogueLine('Вы бодро шагаете в сторону твоего временного жилья'),
        BackgroundLine('room/renovation.jpg'),
        CharacterLine('Arda.png'),
        DialogueLine(
          'Н-да, удачи тебе тут жить, конечно!',
          by: 'Мастер',
          voice: 'intro/19.m4a',
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
        HideCharacterLine('Arda.png')
      ],
    );
    await Future.delayed(200.milliseconds);

    _register();
  }
}
