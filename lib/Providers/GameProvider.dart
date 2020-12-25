import 'dart:math';
import 'package:simple_dungeon/Domain/Dice.dart';
import 'package:simple_dungeon/Domain/Entities/Entity.dart';
import 'package:simple_dungeon/Domain/Entities/Player.dart';
import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  Entity _currentEntity;
  Player _player;
  String _lastRoll;
  String _gameMessage;
  bool _playerCanRoll = true;

  bool get playerCanRoll => _playerCanRoll;
  Player get player => _player;
  String get lastRoll => _lastRoll;
  String get gameMessage => _gameMessage;
  Entity get currentSelectedEntity => _currentEntity;
  bool get showDialog => _currentEntity == null ? false : _currentEntity.health <= 0 && _currentEntity.droppableItem != null;

  set gameMessage(String message) {
    _gameMessage = message;
    notifyListeners();
  }

  set currentSelectedEntity(Entity entity) {
    _currentEntity = entity;
    notifyListeners();
  }

  set lastRoll(String roll) {
    _lastRoll = roll;
    notifyListeners();
  }

  set playerCanRoll(bool canRoll) {
    _playerCanRoll = canRoll;
    notifyListeners();
  }

  GameProvider() {
    _player = new Player();
    _lastRoll = "Roll";
  }

  void _damageEntity(int damage) {
    if (_currentEntity != null) {
      _currentEntity.takeDamage(damage);
      notifyListeners();
    }
  }

  void damageEntity(int damage) => _damageEntity(damage);
  void damagePlayer(int damage) => _damagePlayer(damage);

  void _damagePlayer(int damage) {
    _player.takeDamage(damage);
    notifyListeners();
  }

  void playTurn() async {
    if (_currentEntity != null) {
      playerCanRoll = false;

      int pRoll = player.selectedDie.roll();
      int eRoll = _currentEntity.selectedDie.roll();

      var pD = _getDamage(pRoll, player.attack, currentSelectedEntity.defense);
      var eD = _getDamage(eRoll, currentSelectedEntity.attack, player.defense);

      _damageEntity(pD);
      gameMessage = "You rolled a $pRoll | $pD DMG";
      lastRoll = pRoll.toString();
      _damagePlayer(eD);
      gameMessage += "\n${currentSelectedEntity.name} rolled a $eRoll | $eD DMG";
    }
  }

  int _getDamage(int roll1, int attack, int defense) => max(0, roll1 * attack - defense);
}
