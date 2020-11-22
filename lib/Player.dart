import 'package:SimpleDungeon/Entitiy.dart';

class Player extends Entity {
  Player() {
    super.attack = 20;
    super.entityType = EntityType.Player;
    super.priority = 0;
    super.level = 1;
    super.attack = 10;
    super.defense = 10;
  }
}
