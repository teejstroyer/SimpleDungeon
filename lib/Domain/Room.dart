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
  bool get cleared => !entities.any((i) => i.health > 0);
  int entityCount;
  List<Entity> entities;

  Room(int x, int y, int entityCount) {
    this.x = x;
    this.y = y;
    this.entityCount = entityCount;
    entities = <Entity>[];
    generateEntities(false);
  }

  void generateEntities(bool hasBoss) {
    for (int i = 0; i < entityCount; i++) {
      this.entities.add(randomEntity());
    }
  }

  // ignore: missing_return
  Entity randomEntity() {
    switch (EntityType.values[Random().nextInt(EntityType.values.length)]) {
      case EntityType.Chest:
        return new Chest();
      case EntityType.Dragon:
        return new Dragon();
      case EntityType.Goblin:
        return new Goblin();
    }
  }
}
