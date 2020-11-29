import 'package:SimpleDungeon/Domain/Entities/Entity.dart';
import 'package:flutter/material.dart';
import '../Domain/Entities/Player.dart';

class GameProvider extends ChangeNotifier {
  Player _player;
  Entity _currentEntity;

  GameProvider() {
    _player = new Player();
  }

  Player get player => _player;

  void setCurrentSelectedEntity(Entity entity) {
    _currentEntity = entity;
    notifyListeners();
  }

  Entity getCurrentSelectedEntity() => _currentEntity;

  void damageEntity() {
    if (_currentEntity != null) {
      _currentEntity.takeDamage(5);
      notifyListeners();
    }
  }
}
