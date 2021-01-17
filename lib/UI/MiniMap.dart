import 'dart:math';
import 'package:simple_dungeon/Domain/Room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_dungeon/Providers/GameProvider.dart';

class MiniMap extends StatelessWidget {
  final double miniMapSize;

  const MiniMap({Key key, this.miniMapSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rooms = context.select<GameProvider, List<Room>>((d) => d.rooms);
    var currentRoom = context.select<GameProvider, Room>((d) => d.currentRoom);
    double squareSize = miniMapSize / 4;
    double offsetConstant = 1.4 * squareSize; //center of square

    var mapOffset = Matrix4.translationValues(
      -(currentRoom.x * squareSize - offsetConstant),
      -(currentRoom.y * squareSize - offsetConstant),
      0,
    );

    return Card(
      child: Container(
        height: miniMapSize,
        width: miniMapSize,
        child: InteractiveViewer(
          panEnabled: false,
          transformationController: TransformationController(mapOffset),
          boundaryMargin: EdgeInsets.all(offsetConstant),
          constrained: false,
          scaleEnabled: false,
          child: UnconstrainedBox(
            clipBehavior: Clip.hardEdge,
            child: drawGrid(squareSize, rooms),
          ),
        ),
      ),
    );
  }

  Widget drawGrid(double roomSize, List<Room> rooms) {
    int maxX = rooms.map<int>((e) => e.x).reduce(max);
    int maxY = rooms.map<int>((e) => e.y).reduce(max);

    List<Row> rows = <Row>[];
    for (int y = 0; y <= maxY; y++) {
      List<Widget> w = <Widget>[];
      for (int x = 0; x <= maxX; x++) {
        var room = rooms.firstWhere((r) => r.x == x && r.y == y, orElse: () => null);
        w.add(
          new Container(
            height: roomSize,
            width: roomSize,
            child: Center(
              child: Container(
                height: roomSize * .85,
                width: roomSize * .85,
                decoration: BoxDecoration(
                  color: roomColor(room),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
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

  Color roomColor(Room room) => room == null
      ? Colors.transparent
      : room.current
          ? Colors.yellow
          : room.visited
              ? Colors.green
              : Colors.red;
}
