import 'package:SimpleDungeon/Entity.dart';
import 'dart:math';

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
      // var entity = Entity();
      // entity.entityType = EntityType.Chest;
      var entity = Entity.asEnemy(1, EntityType.Rat, false);
      entity.priority = Random().nextInt(entityCount) + 1; //Priorities will be set later by entity level etc etc

      this.entities.add(entity);
    }
  }
}
