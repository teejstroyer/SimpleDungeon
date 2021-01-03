import 'package:flutter/material.dart';
import 'Entity.dart';

class Goblin extends Entity {
  Goblin() {
    super.name = "Goblin";
    super.attack = 20;
    super.entityType = EntityType.Goblin;
    super.priority = 2;
    super.level = 1;
    super.defense = 10;
    super.health = 100;
    super.maxHealth = 100;
    super.icon = Icons.fire_extinguisher;
    super.color = Colors.green;
  }

  Goblin.fromJson(Map jsonData) : super.fromJson(jsonData);
}
