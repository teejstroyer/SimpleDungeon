import 'dart:math';
import 'Room.dart';

class Dungeon {
  List<Room> rooms;

  Dungeon() {
    rooms = new List<Room>();
  }

  generateRooms(int roomCount) {
    if (rooms.isNotEmpty) rooms.clear();
    rooms.add(new Room(0, 0));
    int posX = 0;
    int posY = 0;

    Random random = new Random();
    while (rooms.length < roomCount) {
      switch (random.nextInt(4)) {
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
      if (!rooms.any((i) => i.x == posX && i.y == posY)) rooms.add(new Room(posX, posY));
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

  String drawGrid(String fillChar, String emptyChar) {
    int maxX = rooms.map<int>((e) => e.x).reduce(max);
    int maxY = rooms.map<int>((e) => e.y).reduce(max);
    var g = '';
    for (int y = 0; y <= maxY; y++) {
      //String row = '';
      for (int x = 0; x <= maxX; x++) {
        g += rooms.any((r) => r.x == x && r.y == y) ? fillChar : emptyChar;
      }
      g += '\n';
    }
    return g;
  }
}
