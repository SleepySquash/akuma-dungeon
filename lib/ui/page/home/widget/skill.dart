import 'package:flutter/material.dart';

import '/domain/model/skill.dart';
import '/ui/widget/backdrop.dart';

class SkillWidget extends StatelessWidget {
  const SkillWidget({
    Key? key,
    this.mySkill,
    this.skill,
  }) : super(key: key);

  final MySkill? mySkill;
  final Skill? skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: ConditionalBackdropFilter(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 160,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
          ),
          padding: const EdgeInsets.all(8),
          child: DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 18),
            child: Row(
              children: [
                Image.asset(
                  'assets/skill/${(mySkill?.skill ?? skill)?.asset}.png',
                  width: 30,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${(mySkill?.skill ?? skill)?.name}'),
                      if (mySkill != null)
                        Text('Lv. ${(mySkill?.level ?? 0) + 1}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
