import 'dart:math';
import 'package:simple_dungeon/Domain/Dice.dart';
import 'package:simple_dungeon/Domain/Dungeon.dart';
import 'package:simple_dungeon/Domain/Entities/Entity.dart';
import 'package:simple_dungeon/Domain/Entities/Player.dart';
import 'package:flutter/material.dart';
import 'package:simple_dungeon/Domain/Room.dart';

class GameProvider extends ChangeNotifier {
  /*Contains Entire Dungeon*/
  Dungeon _dungeon;
  ////////////////////////////////////////////////////
  Entity _currentEntity;
  Player _player;
  String _lastRoll;
  String _gameMessage;
  bool _playerCanRoll = true;
  Room _currentRoom;

  bool canGoDown = false;
  bool canGoLeft = false;
  bool canGoRight = false;
  bool canGoUp = false;

  GameProvider() {
    _player = new Player();
    _lastRoll = "Roll";
    _dungeon = new Dungeon();
    _currentRoom = _dungeon.rooms.firstWhere((i) => i.current);
    canGoDown = isDirectionEnabled(Direction.DOWN);
    canGoLeft = isDirectionEnabled(Direction.LEFT);
    canGoRight = isDirectionEnabled(Direction.RIGHT);
    canGoUp = isDirectionEnabled(Direction.UP);
  }

  bool get playerCanRoll => _playerCanRoll;
  Player get player => _player;
  String get lastRoll => _lastRoll;
  String get gameMessage => _gameMessage;
  Entity get currentSelectedEntity => _currentEntity;
  bool get showDialog => _currentEntity == null ? false : _currentEntity.health <= 0 && _currentEntity.droppableItem != null;
  List<Room> get rooms => _dungeon.rooms;
  Room get currentRoom => _currentRoom;

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
      if (_currentEntity.health > 0) {
        _damagePlayer(eD);
        gameMessage += "\n${currentSelectedEntity.name} rolled a $eRoll | $eD DMG";
      } else {
        setAvailableDirections();
      }
    }
  }

  int _getDamage(int roll1, int attack, int defense) => max(0, roll1 * attack - defense);

  void setCurrentRoom(int x, y) {
    var newCurr = _dungeon.rooms.firstWhere((i) => i.x == x && i.y == y, orElse: () => null);
    if (newCurr != null) {
      newCurr.current = true;
      var curr = currentRoom;
      if (curr != null) {
        curr.current = false;
        if (curr.visited == false) curr.visited = true;
      }
      _currentRoom = newCurr;
      _currentEntity = null;
      notifyListeners();
      setAvailableDirections();
    }
  }

  void moveInDirection(Direction direction) {
    var curr = currentRoom;
    int x = 0, y = 0;
    switch (direction) {
      case Direction.DOWN:
        y++;
        break;
      case Direction.LEFT:
        x--;
        break;
      case Direction.RIGHT:
        x++;
        break;
      case Direction.UP:
        y--;
        break;
    }
    setCurrentRoom(curr.x + x, curr.y + y);
  }

  void setAvailableDirections() {
    canGoDown = isDirectionEnabled(Direction.DOWN);
    canGoLeft = isDirectionEnabled(Direction.LEFT);
    canGoRight = isDirectionEnabled(Direction.RIGHT);
    canGoUp = isDirectionEnabled(Direction.UP);
    notifyListeners();
  }

  bool isDirectionEnabled(Direction direction) {
    int x = _currentRoom.x, y = _currentRoom.y;
    switch (direction) {
      case Direction.LEFT:
        x--;
        break;
      case Direction.RIGHT:
        x++;
        break;
      case Direction.UP:
        y--;
        break;
      case Direction.DOWN:
        y++;
        break;
    }
    Room neighbor = _dungeon.rooms.firstWhere((i) => i.x == x && i.y == y, orElse: () => null);
    return neighbor != null && (neighbor.visited || _currentRoom.cleared);
  }
}
