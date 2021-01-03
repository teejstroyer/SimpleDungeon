import 'package:simple_dungeon/Domain/Dice.dart';
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

  Map<String, dynamic> toJson() => {
        "attack": attack,
        "entityType": entityType.toString(),
        "priority": priority,
        "level": level,
        "defense": defense,
        "health": health,
        "maxHealth": maxHealth,
        "icon": icon.codePoint,
        "color": color.value,
        "name": name,
      };

  Entity();
  Entity.fromJson(Map jsonData) {
    try {
      attack = jsonData["attack"];
      priority = jsonData["priority"];
      level = jsonData["level"];
      defense = jsonData["defense"];
      health = jsonData["health"];
      maxHealth = jsonData["maxHealth"];
      icon = IconData(jsonData["icon"]);
      color = Color(jsonData["color"]);
      name = jsonData["name"];
      switch (jsonData["entityType"]) {
        case "EntityType.Chest":
          entityType = EntityType.Chest;
          color = Colors.brown;
          icon = Icons.account_box;
          break;
        case "EntityType.Dragon":
          entityType = EntityType.Dragon;
          icon = Icons.ac_unit;
          color = Colors.deepOrange;
          break;
        case "EntityType.Goblin":
          entityType = EntityType.Goblin;
          icon = Icons.fire_extinguisher;
          color = Colors.green;
          break;
        default:
          entityType = null;
          icon = Icons.person;
          color = Colors.cyan;
          break;
      }
    } catch (e) {
      print("error constructing Entity from json: $e");
    }
  }
}

enum EntityType { Chest, Dragon, Goblin }
