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

import 'package:akuma/ui/worker/music.dart';
import 'package:akuma/util/audio_utils.dart';
import 'package:akuma/util/novel.dart';
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
  IntroductionController(this._authService, this._musicWorker);

  final Rx<IntroductionStage> stage = Rx(IntroductionStage.novel);

  final RxBool nameIsEmpty = RxBool(true);
  final TextEditingController name = TextEditingController();

  final Rx<Gender> gender = Rx(Gender.male);
  final Rx<Race> race = Rx(Race.ningen);

  final AuthService _authService;
  final MusicWorker _musicWorker;

  final AudioSource _source =
      AudioSource.asset('assets/music/MOSAICWAV_she_already_gone.mp3');

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
    _musicWorker.stop(_source);
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
      options: NovelExtension.options(),
      scenario: [
        MusicLine.asset('mixkit-lost-in-dreams-26.mp3'),
        BackgroundLine.asset('location/mediterranean_town.jpg'),
        const DialogueLine(
          'Ты хватаешься за голову, осматриваешь себя на предмет каких-либо травм.',
        ),
        const DialogueLine('Так, а откуда они должны были взяться?'),
        const DialogueLine('Где ты?'),
        const DialogueLine(
          'Мгновением позже ты понимаешь, что ты не можешь ответить даже на более примитивный вопрос: кто ты?',
        ),
        const DialogueLine(
          'Осмотревшись, ты понимаешь, что стоишь у дороги, отсюда открывается вид на какой-то город.',
        ),
        const DialogueLine('На спине рюкзак, в карманах деньги и... телефон!'),
        const DialogueLine(
          'Ты судорожно достаёшь свой телефон из кармана, пароля нет, разблокируешь его.',
        ),
        const DialogueLine('Симка есть, Интернет ловит, отлично.'),
        const DialogueLine(
          'Ты открываешь галерею - пусто, смотришь контакты - пусто.',
        ),
        const DialogueLine(
            'Ты недоволен собой за то, что не оставил никаких заметок себе на случай таких ситуаций, кем бы ты ни был.'),
        const DialogueLine(
            'Наконец, в заметках ты находишь единственную: в ней листовка с рекламой гильдии путешественников города Алоросс.'),
        const DialogueLine(
            'Зацепка? Едва ли. Ты открываешь историю браузера, но в ней только простые запросы.'),
        const DialogueLine(
            '"Лесбийский хентай с эльфиечками и кошкодевочками", "Порно с дворфами смешное", "Алоросс".'),
        const DialogueLine('Видимо, ты был человеком культуры.'),
        const DialogueLine('Но почему ты ничего не помнишь?'),
        const DialogueLine(
            'Погода стояла дикая, солнце палило твою голову - стал ли солнечный удар причиной отшиба?'),
        const DialogueLine(
            'Вокруг никого, ты решаешь идти вперёд в город перед тобой.'),
        const DialogueLine(
            'По пути ты безуспешно пытаешься связать имеющуюся у тебя информацию в клубок, чтобы распутать его.'),
        const DialogueLine(
            'Современность, какой ты её знаешь, состоит из передовых технологий - телефоны, компьютеры, космос.'),
        const DialogueLine(
            'Около пятисот лет назад появились подземелья или данжи - порталы в измерение монстров.'),
        const DialogueLine(
            'С тех пор человечество тратит огромное количество усилий на борьбу с монстрами.'),
        const DialogueLine(
            'Но жизнь продолжается. Кроме того, вышедшие из данжей более слабые расы спокойно прижились в нашем измерении.'),
        const DialogueLine(
            'Кроме людей, наш мир обитаем дварфами, эльфами, всеми типами ушастых, вампирами.'),
        const DialogueLine(
            'Изначально, конечно, люди объявили этим расам войну - так началась Священная Война на религиозной почве.'),
        const DialogueLine(
            'К счастью, довольно скоро эта война кончилась и теперь люди сосуществуют с существами из измерения Акумы.'),
        const DialogueLine(
            'Акума - это титул, который присваивается сильнейшему дьяволу, что управляет монстрами.'),
        const DialogueLine(
            'Судя по рассказам ушастых, в измерении Акумы лютая тирания, поэтому многие нашли мир в наших землях.'),
        BackgroundLine.asset('location/town.jpg'),
        const DialogueLine('"Алоросс" - вывеска у врат на входе.'),
        const DialogueLine(
            'Возможно, твои заметки всё-таки связаны с разгадкой этой ситуации.'),
        const DialogueLine(
            'Ты решаешь обойти город, чтобы триггернуть какие-либо воспоминания.'),
        const DialogueLine('Но к твоему сожалению никто тебя не узнаёт.'),
        const DialogueLine(
            'Не имея альтернатив, ты отправляешься в гильдию путешественников.'),
        const DialogueLine(
            'В конце концов, именно она является твоей единственной зацепкой.'),
        BackgroundLine.asset('location/guild.jpg'),
        HideImageLine.asset('Arda.png'),
        const DialogueLine(
          'Добрый день!',
          by: 'Мастер',
          voice: FromAsset('intro/1.mp3'),
        ),
        const DialogueLine(
          'Добро пожаловать в гильдию путешественников города Алоросс!',
          by: 'Мастер',
          voice: FromAsset('intro/2.m4a'),
        ),
        const DialogueLine(
          'Я временно заменяю гильдмастера, она... будет позже.',
          by: 'Мастер',
          voice: FromAsset('intro/5.m4a'),
        ),
        const DialogueLine('Ты объясняешь ситуацию гильдмастеру.'),
        const DialogueLine(
          'Ага, понятно. К сожалению, я тоже вижу тебя впервые.',
          by: 'Мастер',
        ),
        const DialogueLine(
          'Но у меня есть идея - ты можешь стать путешественником.',
          by: 'Мастер',
        ),
        const DialogueLine(
          'Выполняя поручения, ты постоянно будешь путешествовать и тем самым обязательно найдёшь кого-нибудь, кто тебя помнит.',
          by: 'Мастер',
        ),
        const DialogueLine(
          'Маловероятно, что ты потерял память внезапно тут и здесь, что-то должно связывать тебя с Алороссом.',
          by: 'Мастер',
        ),
        const DialogueLine(
            'У тебя нет ни малейшей идеи, куда идти и куда податься.'),
        const DialogueLine(
            'Наличных в твоём кармане надолго не хватит, а путешествовия действительно могут тебе помочь.'),
        const DialogueLine('Ты соглашаешься.'),
        const DialogueLine(
            'Твоя цель - найти себя, путешествуя по миру, тебе больше ничего не остаётся.'),
        const DialogueLine(
          'Итак, ты хочешь вступить в ряды путешественников?',
          by: 'Мастер',
          voice: FromAsset('intro/3.mp3'),
        ),
        const DialogueLine(
          'Наш Алоросс - городок небольшой, но поручений тут не меньше, чем в каком-нибудь крупном граде.',
          by: 'Мастер',
          voice: FromAsset('intro/6.m4a'),
        ),
        const DialogueLine(
          'Тебя ждут приключения, слава и гарем эльфиечек, кхм, но не факт.',
          by: 'Мастер',
          voice: FromAsset('intro/7.m4a'),
        ),
        const DialogueLine(
          'Ну, успеешь со всем познакомиться позже, а пока заполни, пожалуйста, вот эту анкету.',
          by: 'Мастер',
          voice: FromAsset('intro/8.m4a'),
        ),
      ],
    );
    await Future.delayed(200.milliseconds);

    _musicWorker.play(_source, volume: 0.4);

    stage.value = IntroductionStage.character;
  }

  Future<void> _introduction() async {
    await Future.delayed(200.milliseconds);
    await Novel.show(
      context: router.context!,
      options: NovelExtension.options(),
      scenario: [
        BackgroundLine.asset('location/guild.jpg'),
        ImageLine.asset('Arda.png'),
        const DialogueLine(
          'Всё отлично, благодарю за анкетку.',
          by: 'Мастер',
          voice: FromAsset('intro/31.m4a'),
        ),
        const DialogueLine(
          'Дай мне пару минут...',
          by: 'Мастер',
          voice: FromAsset('intro/32.m4a'),
        ),
        HideImageLine.asset('Arda.png'),
        const DialogueLine(
            'Ты ждёшь пару минут, пока гильдмастер заполняет бумаги.'),
        const DialogueLine(
            'Гильдмастер достаёт ноутбук, на котором увлечённо что-то делает около минуты.'),
        ImageLine.asset('Arda.png'),
        const DialogueLine(
          'Готово!',
          by: 'Мастер',
          voice: FromAsset('intro/9.m4a'),
        ),
        const DialogueLine(
          'Ну что, поздравляю, теперь ты настоящий путешественник!',
          by: 'Мастер',
          voice: FromAsset('intro/10.m4a'),
        ),
        const DialogueLine(
          'Твой ранг, как и у всех начинающих, F!',
          by: 'Мастер',
        ),
        const DialogueLine(
          'Но ты буквально в шаге от получения SSS титула, я прям вижу по тебе.',
          by: 'Мастер',
          voice: FromAsset('intro/12.m4a'),
        ),
        const DialogueLine(
          'Приходи в гильдию, чтобы брать поручения и задания по закрытию данжей.',
          by: 'Мастер',
          voice: FromAsset('intro/13.m4a'),
        ),
        const DialogueLine(
          'У каждого поручения своя сложность, но и своя награда.',
          by: 'Мастер',
          voice: FromAsset('intro/14.m4a'),
        ),
        const DialogueLine(
          'Помни, что в твоих приключениях немаловажную роль играют твои навыки, экипировка и класс.',
          by: 'Мастер',
          voice: FromAsset('intro/15.m4a'),
        ),
        const DialogueLine(
          'И не забывай, что иногда важно полагаться на свою пати.',
          by: 'Мастер',
          voice: FromAsset('intro/16.m4a'),
        ),
        const DialogueLine(
          'Она будет прикрывать твою спину, брать на себя урон или, наоборот, наносить его.',
          by: 'Мастер',
          voice: FromAsset('intro/17.m4a'),
        ),
        const DialogueLine(
          'По поводу того, где тебе остановиться, есть одна идея.',
          by: 'Мастер',
        ),
        const DialogueLine(
          'Гильдия владеет имуществом, которое город даёт ей для временного размещения путешественников в случае экстренной ситуации.',
          by: 'Мастер',
        ),
        const DialogueLine(
          'Я готов предоставить тебе свободную квартирку, но признаюсь сразу: состояние у неё не ахти.',
          by: 'Мастер',
        ),
        const DialogueLine(
          'Пойдём покажу тебе твои апартаменты.',
          by: 'Мастер',
          voice: FromAsset('intro/18.m4a'),
        ),
        HideImageLine.asset('Arda.png'),
        BackgroundLine.asset('location/town.jpg'),
        const DialogueLine(
          'Вы бодро шагаете в сторону твоего временного жилья',
        ),
        BackgroundLine.asset('room/renovation.jpg'),
        ImageLine.asset('Arda.png'),
        const DialogueLine(
          'Н-да, удачи тебе тут жить, конечно!',
          by: 'Мастер',
          voice: FromAsset('intro/19.m4a'),
        ),
        const DialogueLine(
          'Из-за постоянно открывающихся данжей и отсутствия лишних рук, чтобы с ними сражаться преждевременно...',
          by: 'Мастер',
          voice: FromAsset('intro/21.m4a'),
        ),
        const DialogueLine(
          '...у нас, как ты видишь, проблемы и с жильём, и с продовольствием, и не только.',
          by: 'Мастер',
          voice: FromAsset('intro/22.m4a'),
        ),
        const DialogueLine(
          'Когда открывается данж, у нас есть около нескольких дней, чтобы успеть его закрыть.',
          by: 'Мастер',
          voice: FromAsset('intro/23.m4a'),
        ),
        const DialogueLine(
          'Иначе из данжа выходят монстры и атакуют население.',
          by: 'Мастер',
          voice: FromAsset('intro/24.m4a'),
        ),
        const DialogueLine(
          'Стража справляется с теми, кто подходит близко к границам города.',
          by: 'Мастер',
          voice: FromAsset('intro/25.m4a'),
        ),
        const DialogueLine(
          'Но за их пределами торговцы, молодёжь и путешественники становятся...',
          by: 'Мастер',
          voice: FromAsset('intro/26.m4a'),
        ),
        const DialogueLine(
          'Кхм, путешественник! Я имел в виду, успевают сбежать и спастись в нашем городе, конечно же!',
          by: 'Мастер',
          voice: FromAsset('intro/27.m4a'),
        ),
        const DialogueLine(
          'Ну, вообще, так и есть, это я троллю тебя так, это была сверх-мета-пост-ирония.',
          by: 'Мастер',
          voice: FromAsset('intro/28.m4a'),
        ),
        const DialogueLine(
          'Обустраивайся тут, знакомься с окружением.',
          by: 'Мастер',
          voice: FromAsset('intro/29.m4a'),
        ),
        const DialogueLine(
          'Когда будешь готов, я жду тебя в гильдии.',
          by: 'Мастер',
          voice: FromAsset('intro/30.m4a'),
        ),
        HideImageLine.asset('Arda.png')
      ],
    );
    await Future.delayed(200.milliseconds);

    _register();
  }
}
