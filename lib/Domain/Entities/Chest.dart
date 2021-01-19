import 'package:flutter/material.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'Entity.dart';

class Chest extends Entity {
  Chest() {
    super.name = "Chest";
    super.attack = 0;
    super.color = Colors.brown;
    super.defense = 0;
    super.entityType = EntityType.Chest;
    super.health = 0;
    super.icon = RpgAwesome.uncertainty;
    super.level = 1;
    super.maxHealth = 0;
    super.priority = 1;
  }
}
