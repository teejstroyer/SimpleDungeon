import 'package:flutter/material.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'Entity.dart';

class Dragon extends Entity {
  Dragon() {
    super.name = "Dragon";
    super.attack = 20;
    super.entityType = EntityType.Dragon;
    super.priority = 5;
    super.level = 1;
    super.defense = 10;
    super.health = 150;
    super.maxHealth = 150;
    super.icon = RpgAwesome.dragon;
    super.color = Colors.deepOrange;
  }
}
