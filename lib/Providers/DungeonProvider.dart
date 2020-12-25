import 'dart:math';
import 'package:simple_dungeon/Domain/Room.dart';
import 'package:flutter/material.dart';

class DungeonProvider extends ChangeNotifier {
  List<Room> _rooms;
  Room _currentRoom;

  DungeonProvider() {
    newLevel(1);
  }

  bool get roomCleared => !_currentRoom.entities.any((i) => i.health > 0);

  void newLevel(int level) {
    _rooms = <Room>[];
    generate(Random().nextInt(5) + 5);
    _rooms[Random().nextInt(_rooms.length)].current = true;
    _rooms[Random().nextInt(_rooms.length)].visited = true;
    _currentRoom = _rooms.firstWhere((i) => i.current);
  }

  List<Room> get rooms => [..._rooms].toList();

  Room getCurrentRoom() => _currentRoom;

  bool isDirectionAvailable(Direction direction) {
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
    var neighbor = _rooms.firstWhere((i) => i.x == x && i.y == y, orElse: () => null);
    return neighbor != null && (neighbor.visited || roomCleared);
  }

  void setCurrentRoom(int x, int y) {
    var newCurr = _rooms.firstWhere((i) => i.x == x && i.y == y, orElse: () => null);
    if (newCurr != null) {
      newCurr.current = true;
      var curr = getCurrentRoom();
      if (curr != null) {
        curr.current = false;
        if (curr.visited == false) curr.visited = true;
      }
      _currentRoom = newCurr;
      notifyListeners();
    }
  }

  void moveInDirection(Direction direction) {
    var curr = getCurrentRoom();
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

  void generate(int roomCount) {
    if (_rooms.isNotEmpty) _rooms.clear();
    _rooms.add(new Room(0, 0, 10));
    int posX = 0;
    int posY = 0;

    while (_rooms.length < roomCount) {
      switch (Random().nextInt(4)) {
        case 0:
          posY--;
          break;
        case 1:
          posY++;
          break;
        case 2:
          posX--;
          break;
        case 3:
          posX++;
          break;
      }
      if (!_rooms.any((i) => i.x == posX && i.y == posY)) _rooms.add(new Room(posX, posY, Random().nextInt(4) + 6));
    }
    int minX = _rooms.map<int>((e) => e.x).reduce(min);
    int minY = _rooms.map<int>((e) => e.y).reduce(min);

    for (Room room in _rooms) {
      if (minX < 0)
        room.x += (-1 * minX);
      else if (minX > 0) room.x -= minX;

      if (minY < 0)
        room.y += (-1 * minY);
      else if (minY > 0) room.y -= minY;
    }
  }
}

enum Direction {
  DOWN,
  LEFT,
  RIGHT,
  UP,
}
