import 'package:SimpleDungeon/Entitiy.dart';

class Room {
  int x;
  int y;
  bool current = false;
  bool visited = false;
  int size; //Size is one side of square. Total Spaces is Size Squared
  List<Entity> entities;

  Room(x, y, size) {
    this.x = x;
    this.y = y;
    this.size = size;
    generateEntities(false);
  }

  // We will generate all rooms, then double back to place boss
  void generateEntities(bool hasBoss) {}
}
