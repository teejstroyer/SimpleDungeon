import 'dart:math';
import 'package:flutter/material.dart';
import 'Room.dart';

class Dungeon {
  List<Room> rooms;

  Dungeon() {
    rooms = new List<Room>();
  }

  generate(int roomCount) {
    if (rooms.isNotEmpty) rooms.clear();
    rooms.add(new Room(0, 0, 10));
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
      if (!rooms.any((i) => i.x == posX && i.y == posY)) rooms.add(new Room(posX, posY, 10));
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

  String gridToString(String fillChar, String emptyChar) {
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

  Widget drawGrid(double roomSize) {
    int maxX = rooms.map<int>((e) => e.x).reduce(max);
    int maxY = rooms.map<int>((e) => e.y).reduce(max);

    List<Row> rows = new List<Row>();
    for (int y = 0; y <= maxY; y++) {
      List<Widget> w = new List<Widget>();
      for (int x = 0; x <= maxX; x++) {
        var room = rooms.firstWhere((r) => r.x == x && r.y == y, orElse: () => null);
        var c = room == null
            ? Colors.transparent
            : room.current
                ? Colors.yellow
                : room.visited
                    ? Colors.green
                    : Colors.red;
        w.add(
          new Container(
            height: roomSize,
            width: roomSize,
            child: Center(
              child: Container(
                color: c,
                height: roomSize - 1,
                width: roomSize - 1,
              ),
            ),
          ),
        );
      }
      rows.add(new Row(children: w));
    }
    return Container(
      height: (maxY + 1) * roomSize,
      width: (maxX + 1) * roomSize,
      child: Column(children: rows),
    );
  }

  Container getMiniMap(double squareSize) {
    var currentRoom = rooms.any((i) => i.current) ? rooms.firstWhere((element) => element.current) : rooms.first;
    double miniMapSize = 4 * squareSize;
    double offsetConstant = 1.5 * squareSize;
    var mapOffset = Matrix4.translationValues(-(squareSize * currentRoom.x - offsetConstant), -(squareSize * currentRoom.y - offsetConstant), 0);

    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
          color: Colors.transparent),
      height: miniMapSize,
      width: miniMapSize,
      child: InteractiveViewer(
        transformationController: TransformationController(mapOffset),
        boundaryMargin: EdgeInsets.all(offsetConstant),
        constrained: false,
        scaleEnabled: false,
        child: UnconstrainedBox(clipBehavior: Clip.hardEdge, child: drawGrid(squareSize)),
      ),
    );
  }

  Container getRoom() {
    print("getting room");
    var currentRoom = rooms.any((i) => i.current) ? rooms.firstWhere((element) => element.current) : rooms.first;
    return renderRoom(currentRoom);
  }

  Container renderRoom(Room room) {
    var grid = List<Expanded>();
    List<List<Expanded>> rows = [List<Expanded>()];

    int rowSum = 0;
    for (var entity in room.entities) {
      if (rowSum >= room.entityCount) {
        grid.add(Expanded(flex: rowSum ~/ rows[rows.length - 1].length, child: Row(children: rows[rows.length - 1])));
        rowSum = 0;
        rows.add(List<Expanded>());
      }
      rowSum += entity.priority;
      rows[rows.length - 1].add(
        Expanded(
            flex: entity.priority,
            child: Container(
              color: randomColor(),
              child: Container(child: Center(child: Text(entity.priority.toString()))),
            )),
      );
    }
    return Container(height: 500, width: 500, child: Column(children: grid));
  }

  Container mainGameBox() {
    // TODO
    // each directional movement button should only appear if theres a room in that direction
    /*
    *           UP
    * LEFT renderRoom() RIGHT
    *          DOWN
    */
    return Container();
  }

  Color randomColor() => Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}
