import 'package:SimpleDungeon/Domain/Dice.dart';
import 'package:SimpleDungeon/Domain/Entities/Entity.dart';
import 'package:SimpleDungeon/Domain/Entities/Player.dart';
import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  DiceManager _diceManager = new DiceManager();
  Entity _currentEntity;
  Player _player;

  GameProvider() {
    _player = new Player();
  }

  Player get player => _player;

  void setCurrentSelectedEntity(Entity entity) {
    _currentEntity = entity;
    notifyListeners();
  }

  Entity getCurrentSelectedEntity() => _currentEntity;

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
      // Player roll, current selected die
      // Play Attack Animation
      // Should reduce entities health etc etc
      print("Entity Rolled $eRoll");
      _damagePlayer(eRoll);
    }
  }
}
