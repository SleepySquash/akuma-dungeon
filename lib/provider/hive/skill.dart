

/// [Skill]s must be balanceable, e.g. we'd like to adjust them in the separate
/// [Character]s.
/// 
/// However, [Skill]s might be added to the [Player] based on its [Skill]-tree.
///
/// But [Skill]s must persist their level (exp).

// class MySkillAdapter extends TypeAdapter<MySkill> {
//   @override
//   final typeId = ModelTypeId.skill;

//   @override
//   MySkill read(BinaryReader reader) {
//     final String id = reader.read() as String;
//     final int exp = reader.read() as int;
//     return MySkill(
//       Skills.get(id),
//       exp: exp,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, MySkill obj) {
//     writer.write(obj.skill.id);
//     writer.write(obj.level);
//   }
// }
