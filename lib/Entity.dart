// import 'dart:math';

enum EntityType { Chest, Rock, Roach, Rat, Lizard }
const Map baseEntityStats = {
  // EntityType: [Dam, Def, Hlth]
  EntityType.Chest: [0, 0, -1],
  EntityType.Rock: [0, 100, -1],
  EntityType.Roach: [1, 0, 5],
  EntityType.Rat: [2, 2, 10],
  EntityType.Lizard: [3, 3, 15]
};

class Entity {
  int _baseDamage;
  int _baseDefense;
  int _baseHealth;

  bool isBoss = false;
  bool isDestructible = true;
  bool canOpen = false;

  int level;
  int damage;
  int defense;
  int health;
  int priority;
  EntityType entityType;

  Entity([this.level, this._baseDamage, this._baseDefense, this._baseHealth, this.isBoss]) {
    damage = level * _baseDamage;
    defense = level * _baseDefense;
    health = level * _baseHealth;
  }

  Entity.asChest(int level, EntityType type) {
    this.level = level;
    isBoss = false;
    isDestructible = false;
    canOpen = true;
    entityType = type;

    _setBaseStats(baseEntityStats[type]);
  }

  Entity.asEnemy(int level, EntityType type, bool isBoss) {
    this.level = level;
    this.isBoss = isBoss;
    isDestructible = true;
    canOpen = false;
    entityType = type;

    _setBaseStats(baseEntityStats[type]);
  }

  void _setBaseStats(List<int> stats) {
    _baseDamage = stats[0];
    _baseDefense = stats[1];
    _baseHealth = stats[2];

    damage = level * _baseDamage;
    defense = level * _baseDefense;
    health = level * _baseHealth;
  }

  void attack(Entity enemy) {}
  void defend(int value) {}
}

class Enemy extends Entity {
  String name = "";
  int numberOfDie = 1;
  int maxDieValue = 6;

  Enemy({int level, List<int> baseStats, bool isBoss}) : super(level, baseStats[0], baseStats[1], baseStats[2], isBoss);

  void attack(Entity enemy) {
    if (!isDestructible) {
      print("indestructible");
      return;
    }
    // roll for attack
    // enemy.defend(rollResult)
    int atk = rollForAttack();
    enemy.defend(atk);
  }

  int rollForAttack() {
    // return Random().nextInt(damage);
    return damage;
  }

  int rollForDefense() {
    print("not implemented");
    return 0;
  }

  void defend(int damage) {
    health -= damage;
    if (health <= 0) {
      print("$name has died");
    }
  }
}

class Chest extends Entity {
  int contents = 5; // This will be something different later, obviously

  // Chest({int level, List<int> baseStats, bool isBoss}) : super(level, baseStats[0], baseStats[1], baseStats[2], isBoss);
}
