import 'package:simple_dungeon/Domain/Entities/Entity.dart';
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
    var e = EntityType.values[Random().nextInt(EntityType.values.length)];
    switch (e) {
      case EntityType.Chest:
        return new Chest();
      case EntityType.Dragon:
        return new Dragon();
      case EntityType.Goblin:
        return new Goblin();
    }
  }
}
