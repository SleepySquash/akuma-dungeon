// ignore_for_file: constant_identifier_names

enum Rank {
  Akuma,
  SSS,
  SS,
  S,
  A,
  B,
  C,
  D,
  E,
  F,
}

extension RankConversion on int {
  Rank get toRank {
    if (this > 1000000) {
      return Rank.Akuma;
    } else if (this > 100 * 5 * 5 * 5 * 5 * 5 * 5 * 5) {
      return Rank.SSS;
    } else if (this > 100 * 5 * 5 * 5 * 5 * 5 * 5) {
      return Rank.SS;
    } else if (this > 100 * 5 * 5 * 5 * 5 * 5) {
      return Rank.S;
    } else if (this > 100 * 5 * 5 * 5 * 5) {
      return Rank.A;
    } else if (this > 100 * 5 * 5 * 5) {
      return Rank.B;
    } else if (this > 100 * 5 * 5) {
      return Rank.C;
    } else if (this > 100 * 5) {
      return Rank.D;
    } else if (this > 100) {
      return Rank.E;
    }

    return Rank.F;
  }
}
