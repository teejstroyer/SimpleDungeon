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
  bool _playerCanRoll = true;

  bool get playerCanRoll => _playerCanRoll;
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

  void _damagePlayer(int damage) {
    _player.takeDamage(damage);
    notifyListeners();
  }

  void playTurn() async {
    // Play Dice Roll Animation
    if (_currentEntity != null) {
      playerCanRoll = false;
      int pRoll = _diceManager.roll(player.selectedDie);
      int eRoll = _diceManager.roll(_currentEntity.selectedDie);
      _damageEntity(pRoll * 2);
      gameMessage = "You rolled a $pRoll";
      lastRoll = pRoll.toString();
      _damagePlayer(eRoll);
      gameMessage += "\n${currentSelectedEntity.name} rolled a $eRoll";
    }
  }
}
