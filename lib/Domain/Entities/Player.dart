import 'package:simple_dungeon/Domain/Entities/Entity.dart';
import 'package:flutter/material.dart';

class Player extends Entity {
  Player() {
    super.attack = 20;
    super.entityType = null;
    super.priority = 0;
    super.level = 1;
    super.defense = 10;
    super.health = 100;
    super.maxHealth = 100;
    super.icon = Icons.person;
    super.color = Colors.cyan;
  }
}
