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
          MusicLine.asset('MOSAICWAV_she_already_gone.mp3'),
          BackgroundLine.asset('location/guild.jpg'),
          ImageLine.asset('Arda.png'),
          const DialogueLine(
            'Отлично!',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Теперь ты сможешь мутузить хотя бы слаймов, замечательно.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Ну, в таком случае, хочу попросить тебя привыкнуть к сражению со слаймами, выполнив 1-2 поручения.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'И тогда я буду уверен, что могу рекомендовать тебя в пати для зачистки данжей.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Кстати, как твоя, ну, амнезия?',
            by: 'Мастер',
          ),
          const DialogueLine('Действительно, как твоя амнезия?'),
          const DialogueLine(
              'Прошло уже несколько дней с тех пор, как ты стал путешественником.'),
          const DialogueLine(
              'Выполнение поручений выматывает, но в то же время дают тебе опыт.'),
          const DialogueLine('Ты не приблизился к разгадке своих мыслей.'),
          const DialogueLine(
            'Ага, понятно.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Я буду надеяться, что репутация поможет кому-нибудь узнать тебя.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Напоминаю, что квесты - это прямой путь завоевать репутацию среди населения.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Успешное закрытие данжей и повышение контроля в городе тоже гарантирует распространение приятных слухов о тебе.',
            by: 'Мастер',
          ),
          const DialogueLine(
            'Чем больше люди говорят о тебе, тем вероятнее, что мы найдём кого-нибудь из твоих друзей или родных.',
            by: 'Мастер',
          ),
          const DialogueLine('Гильдмастер прав, так работают люди.'),
          const DialogueLine(
              'С этими мыслями ты отправился смотреть доску поручений.'),
        ]),
      ];
}
