// ignore_for_file: constant_identifier_names

import 'package:decimal/decimal.dart';

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

extension RankConversionOnDecimal on Decimal {
  Rank toRank() {
    if (this > Decimal.fromInt(10000000)) {
      return Rank.Akuma;
    } else if (this > Decimal.fromInt(1000000)) {
      return Rank.SSS;
    } else if (this > Decimal.fromInt(500000)) {
      return Rank.SS;
    } else if (this > Decimal.fromInt(100000)) {
      return Rank.S;
    } else if (this > Decimal.fromInt(50000)) {
      return Rank.A;
    } else if (this > Decimal.fromInt(15000)) {
      return Rank.B;
    } else if (this > Decimal.fromInt(5000)) {
      return Rank.C;
    } else if (this > Decimal.fromInt(1000)) {
      return Rank.D;
    } else if (this > Decimal.fromInt(100)) {
      return Rank.E;
    }

    return Rank.F;
  }
}

extension RankConversionOnInt on int {
  Rank toRank() {
    if (this > 10000000) {
      return Rank.Akuma;
    } else if (this > 1000000) {
      return Rank.SSS;
    } else if (this > 500000) {
      return Rank.SS;
    } else if (this > 100000) {
      return Rank.S;
    } else if (this > 50000) {
      return Rank.A;
    } else if (this > 15000) {
      return Rank.B;
    } else if (this > 5000) {
      return Rank.C;
    } else if (this > 1000) {
      return Rank.D;
    } else if (this > 100) {
      return Rank.E;
    }

    return Rank.F;
  }
}
