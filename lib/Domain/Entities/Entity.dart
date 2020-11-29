import 'package:flutter/material.dart';

class Entity {
  EntityType entityType;
  int priority = 1;
  int level;
  int attack;
  int defense;
  int maxHealth;
  int health;
  Color color = Colors.grey;
  IconData icon = Icons.no_encryption;

  void takeDamage(int damage) {
    health -= damage;
    if (health < 0) health = 0;
  }
}

enum EntityType { Chest, Dragon, Goblin }
