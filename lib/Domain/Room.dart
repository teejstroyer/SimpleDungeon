import 'package:SimpleDungeon/Domain/Entities/Entity.dart';
import 'dart:math';

import 'Entities/Chest.dart';
import 'Entities/Dragon.dart';
import 'Entities/Goblin.dart';

class Room {
  int x;
  int y;
  bool current = false;
  bool visited = false;
  int entityCount;
  List<Entity> entities;

  Room(x, y, entityCount) {
    this.x = x;
    this.y = y;
    this.entityCount = entityCount;
    entities = new List<Entity>();
    generateEntities(false);
  }

  void generateEntities(bool hasBoss) {
    for (int i = 0; i < entityCount; i++) {
      this.entities.add(randomEntity());
    }
  }

  // ignore: missing_return
  Entity randomEntity() {
    Entity ent = Entity();
    switch (EntityType.values[Random().nextInt(EntityType.values.length)]) {
      case EntityType.Chest:
        ent = new Chest();
        break;
      case EntityType.Dragon:
        ent = new Dragon();
        break;
      case EntityType.Goblin:
        ent = new Goblin();
        break;
    }
    ent.rewardType = RewardType.values[Random().nextInt(RewardType.values.length)];
    return ent;
  }
}
