abstract class Stat {
  const Stat(this.amount, [int? max]) : max = max ?? amount * 5;
  final int amount;
  final int max;
}

class CritRateStat extends Stat {
  const CritRateStat(super.amount);
}

class CritDmgStat extends Stat {
  const CritDmgStat(super.amount);
}

class AtkPercentStat extends Stat {
  const AtkPercentStat(super.amount);
}

class DefPercentStat extends Stat {
  const DefPercentStat(super.amount);
}

class AtkStat extends Stat {
  const AtkStat(super.amount);
}

class DefStat extends Stat {
  const DefStat(super.amount);
}

class HpStat extends Stat {
  const HpStat(super.amount);
}

class HpPercentStat extends Stat {
  const HpPercentStat(super.amount);
}
