import 'package:simple_dungeon/Domain/Dice.dart';
import 'package:simple_dungeon/Domain/Entities/Entity.dart';
import 'package:simple_dungeon/Domain/Entities/Player.dart';
import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  DiceManager _diceManager = new DiceManager();
  Entity _currentEntity;
  Player _player;
  String _lastRoll;
  String _gameMessage;

  Player get player => _player;
  String get lastRoll => _lastRoll;
  String get gameMessage => _gameMessage;
  Entity get currentSelectedEntity => _currentEntity;

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

  void _damagePlayer(int damage) {
    _player.takeDamage(damage);
    notifyListeners();
  }

  void playTurn() async {
    // Play Dice Roll Animation
    if (_currentEntity != null) {
      int pRoll = _diceManager.roll(player.selectedDie);
      int eRoll = _diceManager.roll(_currentEntity.selectedDie);
      print("Player Rolled $pRoll");
      _damageEntity(pRoll);
      await new Future.delayed(const Duration(seconds: 1));
      lastRoll = pRoll.toString();
      // Player roll, current selected die
      // Play Attack Animation
      // Should reduce entities health etc etc
      print("Entity Rolled $eRoll");
      _damagePlayer(eRoll);
      gameMessage = "${currentSelectedEntity.name} rolled a $eRoll";
    }
  }
}
