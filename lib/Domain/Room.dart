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
    switch (EntityType.values[Random().nextInt(EntityType.values.length)]) {
      case EntityType.Chest:
        return new Chest();
      case EntityType.Dragon:
        return new Dragon();
      case EntityType.Goblin:
        return new Goblin();
    }
  }

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "current": current,
        "visited": visited,
        "entityCount": entityCount,
        "entities": entities.map((entity) => entity.toJson()).toList(),
      };

  Room.fromJson(Map jsonData) {
    try {
      x = jsonData["x"];
      y = jsonData["y"];
      current = jsonData["current"];
      visited = jsonData["visited"];
      entityCount = jsonData["entityCount"];
      entities = new List<Entity>();
      (jsonData["entities"] as List).forEach((entity) {
        entities.add(Entity.fromJson(entity));
      });
    } catch (e) {
      print("error constructing Room from json: $e");
    }
  }
}
