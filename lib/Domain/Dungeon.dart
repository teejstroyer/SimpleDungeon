import 'dart:math';
import 'package:simple_dungeon/Domain/Room.dart';

class Dungeon {
  List<Room> rooms;

  Dungeon() {
    newLevel(1);
  }

  void newLevel(int level) {
    rooms = <Room>[];
    generate(Random().nextInt(5) + 5);
    rooms[Random().nextInt(rooms.length)].current = true;
  }

  void generate(int roomCount) {
    if (rooms.isNotEmpty) rooms.clear();
    rooms.add(new Room(0, 0, 10));
    int posX = 0;
    int posY = 0;

    while (rooms.length < roomCount) {
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
      if (!rooms.any((i) => i.x == posX && i.y == posY)) rooms.add(new Room(posX, posY, Random().nextInt(4) + 6));
    }
    int minX = rooms.map<int>((e) => e.x).reduce(min);
    int minY = rooms.map<int>((e) => e.y).reduce(min);

    for (Room room in rooms) {
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
