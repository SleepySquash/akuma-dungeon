import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '/domain/model/location.dart';
import '/domain/model/location/all.dart';
import '/ui/widget/locked.dart';
import '/util/platform_utils.dart';
import 'controller.dart';

class CityView extends StatelessWidget {
  const CityView({Key? key}) : super(key: key);

  static Future<T?> show<T>(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<T>(
      RawDialogRoute<T>(
        pageBuilder: (context, animation, secondary) => const CityView(),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (context, animation, secondary, child) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CityController(Get.find()),
      builder: (CityController c) {
        Widget place(Location? location) {
          return Obx(() {
            return LockedWidget(
              locked: location == null,
              borderRadius: BorderRadius.circular(20),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                disabledColor: Colors.green,
                color: c.location.value.id.val == location?.id
                    ? Colors.green
                    : Colors.blue,
                padding: const EdgeInsets.all(16),
                onPressed: c.location.value.id.val == location?.id
                    ? null
                    : () => c.setLocation(location!),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(location?.icon, color: Colors.white),
                    const SizedBox(height: 5),
                    Text(
                      location?.name ?? '...',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          });
        }

        return Stack(
          children: [
            SlidingUpPanel(
              controller: c.panelController,
              parallaxEnabled: true,
              parallaxOffset: 0.5,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  InteractiveViewer(
                    child: Image.asset(
                      'assets/background/misc/map.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        place(const DarkLandsLocation()),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            place(const AlorossLocation()),
                            const SizedBox(width: 5),
                            place(const AlorossVillageLocation()),
                          ],
                        ),
                        const SizedBox(height: 5),
                        place(const LahtaburgLocation()),
                        const SizedBox(height: 5),
                        place(const CapitalLocation()),
                      ],
                    ),
                  ),
                ],
              ),
              backdropEnabled: true,
              backdropOpacity: 0.2,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              panelBuilder: () {
                return Obx(() {
                  return Column(
                    children: [
                      const SizedBox(height: 12),
                      Center(
                        child: Container(
                          width: 60,
                          height: 3,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCCCCCC),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 16),
                          Icon(
                            c.location.value.location.icon,
                            size: 32,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            c.location.value.location.name,
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(width: 16),
                          if (context.isMobile) const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const SizedBox(height: 6),
                            ListTile(
                              leading: const Icon(Icons.control_camera),
                              title: const Text(
                                'Контроль',
                                style: TextStyle(fontSize: 24),
                              ),
                              subtitle: const Text(
                                  'Чем выше показатель, тем безопаснее жителям и торговцам.'),
                              trailing: Text(
                                '${c.location.value.control}',
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.red),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text(
                                'Ваша репутация',
                                style: TextStyle(fontSize: 24),
                              ),
                              subtitle:
                                  const Text('Влияет на отношение к Вам.'),
                              trailing: Text(
                                '${c.location.value.reputation}',
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.red),
                              ),
                            ),
                            if (c.location.value.location.features
                                .isNotEmpty) ...[
                              const Divider(),
                              ...c.location.value.location.features.map((e) {
                                IconData? icon;
                                String? desc;

                                if (e is AdventurerGuildFeature) {
                                  icon = Icons.church;
                                  desc = 'Есть гильдия путешественников';
                                } else if (e is RealEstateFeature) {
                                  switch (e.type) {
                                    case RealEstateType.apartment:
                                      icon = Icons.apartment;
                                      desc = 'Есть жильё (апартаменты)';
                                      break;

                                    case RealEstateType.villa:
                                      icon = Icons.villa;
                                      desc = 'Есть жильё (вилла)';
                                      break;
                                  }
                                } else if (e is StoreFeature) {
                                  icon = Icons.store;
                                  desc = 'Есть магазины';
                                }

                                return ListTile(
                                  leading: Icon(icon),
                                  title: Text(desc ?? '...'),
                                );
                              }),
                            ],
                            if (c.location.value.location.description !=
                                null) ...[
                              const Divider(),
                              ListTile(
                                leading: const Icon(Icons.info),
                                title: Text(
                                    c.location.value.location.description!),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  );
                });
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 16),
                child: FloatingActionButton(
                  mini: false,
                  onPressed: Navigator.of(context).pop,
                  child: const Icon(Icons.close_rounded),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
