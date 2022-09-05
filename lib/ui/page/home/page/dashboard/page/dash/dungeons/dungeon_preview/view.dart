import 'package:audioplayers/audioplayers.dart' show Source;
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '/domain/model/dungeon.dart';
import '/domain/model/item/standard.dart';
import '/domain/model/rarity.dart';
import '/domain/model/task.dart';
import '/router.dart';
import '/theme.dart';
import '/ui/page/home/page/item/view.dart';
import '/ui/page/home/widget/wide_button.dart';
import '/ui/widget/button.dart';
import '/ui/widget/modal_popup.dart';
import 'controller.dart';

class DungeonDifficulty {
  const DungeonDifficulty({
    required this.stages,
    this.name = 'Сложность',
    this.level = 1,
    this.background,
    this.music,
    this.rewards,
  });

  final String name;
  final int level;

  final List<DungeonStage> stages;

  final String? background;

  final Source? music;

  final List<TaskReward>? rewards;
}

class DungeonPreviewView extends StatelessWidget {
  const DungeonPreviewView(
    this.difficulties, {
    Key? key,
    this.name = 'Dungeon',
    this.background,
    this.description,
  }) : super(key: key);

  final String name;
  final String? background;
  final String? description;
  final List<DungeonDifficulty> difficulties;

  static Future<T?> show<T>(
    BuildContext context, {
    String name = 'Dungeon',
    String? background,
    String? description,
    required List<DungeonDifficulty> difficulties,
  }) {
    return ModalPopup.show(
      context: context,
      noPadding: true,
      child: DungeonPreviewView(
        difficulties,
        name: name,
        description: description,
        background: background,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DungeonPreviewController(),
      builder: (DungeonPreviewController c) {
        Widget reward(int i, TaskReward r) {
          Widget? expanded;
          String? text;
          Rarity rarity = Rarity.common;

          if (r is ExpReward) {
            expanded = const Text('EXP');
            text = '${r.amount}';
          } else if (r is MoneyReward) {
            expanded = WidgetButton(
              onPressed: () => ItemView.show(
                context: context,
                hero: 'Dogecoin_$i',
                item: const Dogecoin(),
              ),
              child: Hero(
                tag: 'Dogecoin_$i',
                child: Image.asset('assets/item/resource/Dogecoin.png'),
              ),
            );
            text = '${r.amount}';
          } else if (r is RankReward) {
            expanded = const Text('Rank');
            text = '${r.amount}';
          } else if (r is ControlReward) {
            expanded = const Text('Control');
            text = '${r.amount}';
          } else if (r is ReputationReward) {
            expanded = const Text('Rep');
            text = '${r.amount}';
          } else if (r is RandomItemReward) {
            expanded = WidgetButton(
              onPressed: () => ItemView.show(
                context: context,
                hero: '${r.item.asset}_$i',
                item: r.item,
              ),
              child: Hero(
                tag: '${r.item.asset}_$i',
                child: Image.asset('assets/item/${r.item.asset}.png'),
              ),
            );
            text = '${r.min}-${r.max}';
            rarity = r.item.rarity;
          } else if (r is ItemReward) {
            expanded = WidgetButton(
              onPressed: () => ItemView.show(
                context: context,
                hero: '${r.item.asset}_$i',
                item: r.item,
              ),
              child: Hero(
                tag: '${r.item.asset}_$i',
                child: Image.asset('assets/item/${r.item.asset}.png'),
              ),
            );
            text = '${r.count * r.item.count}';
            rarity = r.item.rarity;
          }

          return Container(
            width: 80,
            height: 100,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: rarity.color.withOpacity(0.56),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                CustomBoxShadow(
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.2),
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: Center(child: expanded ?? Container())),
                Container(
                  width: double.infinity,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(child: Text(text ?? '')),
                )
              ],
            ),
          );
        }

        Widget difficulty(int i) {
          DungeonDifficulty difficulty = difficulties[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Obx(() {
              return MaterialButton(
                onPressed: () => c.selectedDifficulty.value = i,
                color: c.selectedDifficulty.value == i
                    ? Colors.blue
                    : Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(fontSize: 19, color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                    child: Row(
                      children: [
                        Text('${difficulty.name} ${i + 1}'),
                        const Spacer(),
                        Text('Ур. ${difficulty.level}'),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _HeaderDelegate(title: name, asset: background),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate.fixed([
                        const SizedBox(height: 10),
                        if (description != null)
                          ListTile(title: Text(description!)),
                        const ListTile(title: Text('Награды')),
                        ScrollConfiguration(
                          behavior: AllScrollBehavior(),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Obx(() {
                              DungeonDifficulty difficulty =
                                  difficulties[c.selectedDifficulty.value];
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: (difficulty.rewards ?? [])
                                    .mapIndexed((i, e) => reward(i, e))
                                    .toList(),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...difficulties.mapIndexed((i, e) => difficulty(i)),
                        const SizedBox(height: 10),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: WideButton(
                onPressed: () {
                  DungeonDifficulty difficulty =
                      difficulties[c.selectedDifficulty.value];
                  router.dungeon(
                    Dungeon(
                      music: difficulty.music,
                      background: difficulty.background,
                      stages: difficulty.stages,
                      rewards: difficulty.rewards,
                    ),
                  );

                  Navigator.of(context).pop(true);
                },
                child: const Center(child: Text('Приступить')),
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  const _HeaderDelegate({
    this.title = '',
    this.asset,
  });

  final String title;
  final String? asset;

  @override
  double get maxExtent => 264;

  @override
  double get minExtent => 84;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration(
        stretchTriggerOffset: maxExtent,
        onStretchTrigger: () async {},
      );

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = shrinkOffset / maxExtent;

    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: progress,
            child: const ColoredBox(color: Colors.blue),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: 1 - progress,
            child:
                Image.asset('assets/background/$asset.jpg', fit: BoxFit.cover),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0x00000000),
                  const Color(0x00000000),
                  Color.lerp(
                    const Color(0x80000000),
                    const Color(0x00000000),
                    progress,
                  )!,
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.lerp(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              const EdgeInsets.only(bottom: 16),
              progress,
            ),
            alignment: Alignment.lerp(
              Alignment.bottomLeft,
              Alignment.bottomCenter,
              progress,
            ),
            child: Text(
              title,
              style: TextStyle.lerp(
                Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.white),
                Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white),
                progress,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AllScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => PointerDeviceKind.values.toSet();
}