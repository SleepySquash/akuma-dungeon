import 'package:flutter/material.dart';
import 'package:novel/novel.dart';

import '/domain/model/task.dart';

class SecondStepsTask extends Task {
  const SecondStepsTask();

  @override
  String get id => 'chapter1_second_steps';

  @override
  String get name => 'Вторые шаги';

  @override
  String? get subtitle => 'Ты возвращаешься с мечом';

  @override
  IconData get icon => Icons.swipe;

  @override
  List<TaskCriteria> get criteria => const [WeaponEquippedCriteria(null)];

  @override
  List<TaskStep> get steps => [
        NovelStep([
          const MusicLine('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine('location/guild.jpg'),
          CharacterLine('Arda.png'),
          DialogueLine(
            'Отлично!',
            by: 'Мастер',
          ),
          DialogueLine(
            'Теперь ты сможешь мутузить хотя бы слаймов, замечательно.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Ну, в таком случае, хочу попросить тебя привыкнуть к сражению со слаймами, выполнив 1-2 поручения.',
            by: 'Мастер',
          ),
          DialogueLine(
            'И тогда я буду уверен, что могу рекомендовать тебя в пати для зачистки данжей.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Кстати, как твоя, ну, амнезия?',
            by: 'Мастер',
          ),
          DialogueLine('Действительно, как твоя амнезия?'),
          DialogueLine(
              'Прошло уже несколько дней с тех пор, как ты стал путешественником.'),
          DialogueLine(
              'Выполнение поручений выматывает, но в то же время дают тебе опыт.'),
          DialogueLine('Ты не приблизился к разгадке своих мыслей.'),
          DialogueLine(
            'Ага, понятно.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Я буду надеяться, что репутация поможет кому-нибудь узнать тебя.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Напоминаю, что квесты - это прямой путь завоевать репутацию среди населения.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Успешное закрытие данжей и повышение контроля в городе тоже гарантирует распространение приятных слухов о тебе.',
            by: 'Мастер',
          ),
          DialogueLine(
            'Чем больше люди говорят о тебе, тем вероятнее, что мы найдём кого-нибудь из твоих друзей или родных.',
            by: 'Мастер',
          ),
          DialogueLine('Гильдмастер прав, так работают люди.'),
          DialogueLine(
              'С этими мыслями ты отправился смотреть доску поручений.'),
        ]),
      ];
}
