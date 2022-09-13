import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/domain/model/commission.dart';
import '/domain/model/item/all.dart';
import '/domain/model/rarity.dart';
import '/domain/model/reward.dart';
import '/domain/model/task.dart';
import '/router.dart';
import '/theme.dart';
import '/ui/page/home/page/item/view.dart';
import '/ui/page/home/widget/slivers.dart';
import '/ui/page/home/widget/wide_button.dart';
import '/ui/widget/button.dart';
import '/ui/widget/modal_popup.dart';
import '/util/message_popup.dart';
import 'controller.dart';

class CommissionPreviewView extends StatelessWidget {
  const CommissionPreviewView({
    Key? key,
    required this.commission,
    this.onAccept,
    this.onComplete,
  }) : super(key: key);

  final MyCommission commission;
  final void Function()? onAccept;
  final void Function()? onComplete;

  static Future<T?> show<T>(
    BuildContext context, {
    required MyCommission commission,
    void Function()? onAccept,
    void Function()? onComplete,
  }) {
    return ModalPopup.show(
      context: context,
      noPadding: true,
      child: CommissionPreviewView(
        commission: commission,
        onAccept: onAccept,
        onComplete: onComplete,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CommissionPreviewController(),
      builder: (CommissionPreviewController c) {
        Widget reward(int i, Reward r) {
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
                child: Image.asset('assets/item/resource/dogecoin.png'),
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
            rarity = r.item.rarity;

            if (r is MinMaxItemReward) {
              text = '${r.min}-${r.max}';
            } else if (r is ChanceItemReward) {
              text = '${r.chance * 100}%';
            } else {
              text = '${r.count * r.item.count}';
            }
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

        String? description = commission.task.description;

        String? background = commission.task.background;
        if (background == null) {
          for (int i = 0;
              background == null && i < commission.task.steps.length;
              ++i) {
            TaskStep step = commission.task.steps[i];
            if (step is DungeonStep) {
              background = step.settings.background;
              if (background != null) {
                background = 'location/$background';
              }
            }
          }
        }

        List<Reward> rewards = commission.task.rewards;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: HeaderDelegate(
                      title: commission.task.name,
                      asset: background,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate.fixed([
                        const SizedBox(height: 10),
                        if (description != null)
                          ListTile(title: Text(description)),
                        if (rewards.isNotEmpty) ...[
                          const ListTile(title: Text('Награды')),
                          ScrollConfiguration(
                            behavior: AllScrollBehavior(),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: rewards
                                    .mapIndexed((i, e) => reward(i, e))
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
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
                onPressed: commission.accepted && !commission.isCompleted
                    ? null
                    : () {
                        if (!commission.accepted) {
                          onAccept?.call();
                          MessagePopup.snackbar('Поручение принято');
                          Navigator.of(context).pop(true);
                        } else if (commission.isCompleted) {
                          onComplete?.call();
                          MessagePopup.snackbar('Поручение выполнено');
                          Navigator.of(context).pop(true);
                          _rewards(commission.task.rewards);
                        }
                      },
                child: commission.accepted
                    ? commission.isCompleted
                        ? const Center(child: Text('Выполнить'))
                        : const Center(child: Text('Уже принято'))
                    : const Center(child: Text('Принять')),
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  void _rewards(List<Reward> rewards) {
    ModalPopup.show(
      context: router.context!,
      maxWidth: 400,
      child: Builder(builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            const ListTile(title: Text('Thank you for your work!')),
            const Divider(),
            const ListTile(title: Text('Rewards:')),
            ...rewards.map((e) {
              IconData? icon;
              Widget? title;

              if (e is MoneyReward) {
                icon = Icons.money;
                title = Text('${e.amount} gold');
              } else if (e is ExpReward) {
                icon = Icons.person;
                title = Text('${e.amount} experience');
              } else if (e is RankReward) {
                icon = Icons.add_card;
                title = Text('${e.amount} rank progression');
              } else if (e is ItemReward) {
                if (e.count == 0) {
                  return Container();
                }

                icon = Icons.check_box;
                title = Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/item/${e.item.asset}.png', height: 30),
                    const SizedBox(width: 5),
                    Text('${e.item.count * e.count} ${e.item.name}'),
                  ],
                );
              } else if (e is ControlReward) {
                icon = Icons.control_camera;
                title = Text('${e.amount} control');
              } else if (e is ReputationReward) {
                icon = Icons.people;
                title = Text('${e.amount} reputation');
              }

              return ListTile(
                leading: icon == null ? null : Icon(icon),
                title: title,
              );
            }),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      }),
    );
  }
}
