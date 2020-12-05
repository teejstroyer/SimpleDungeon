import 'package:SimpleDungeon/Domain/Dice.dart';
import 'package:flutter/material.dart';

class Entity {
  Color color = Colors.grey;
  EntityType entityType;
  IconData icon = Icons.no_encryption;
  String name;
  int attack;
  int defense;
  int health;
  int level;
  int maxHealth;
  int priority = 1;
  Die selectedDie = Die.SixSideRegular;

  void takeDamage(int damage) {
    health -= damage;
    if (health < 0) health = 0;
  }
}

enum EntityType { Chest, Dragon, Goblin }
