import 'dart:math';

enum Die {
  ThreeSideRegular,
  SixSideRegular,
}

class DieStats {
  final List<int> odds;
  final String modifiers;
  DieStats(this.odds, this.modifiers);
}

class DiceManager {
  final Map<Die, DieStats> _diceList = {
    Die.SixSideRegular: DieStats([1, 2, 3, 4, 5, 6], ""),
    Die.ThreeSideRegular: DieStats([1, 2, 3], ""),
  };
  int roll(Die die) => _diceList[die].odds[Random().nextInt(_diceList[die].odds.length)];
}
