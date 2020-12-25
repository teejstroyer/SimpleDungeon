import 'dart:math';
import 'package:simple_dungeon/Domain/Item.dart';

enum DieType {
  ThreeSideRegular,
  SixSideRegular,
}

class DieStats {
  final List<int> odds;
  final String modifiers;
  DieStats(this.odds, this.modifiers);
}

extension DiceManager on Die {
  int roll() {
    DieStats s;
    switch (this.type) {
      case DieType.ThreeSideRegular:
        s = DieStats([1, 2, 3, 4, 5, 6], "");
        break;
      case DieType.SixSideRegular:
        s = DieStats([1, 2, 3], "");
        break;
    }
    return s.odds[Random().nextInt(s.odds.length)];
  }
}

class Die extends Item {
  final DieType type;
  Die(this.type) : super(type.toString());
}
