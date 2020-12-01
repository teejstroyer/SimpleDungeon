import 'dart:math';
import 'package:SimpleDungeon/Providers/DungeonProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Domain/Room.dart';

class MiniMap extends StatelessWidget {
  final double miniMapSize;

  const MiniMap({Key key, this.miniMapSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rooms = Provider.of<DungeonProvider>(context, listen: true).rooms;
    var currentRoom = Provider.of<DungeonProvider>(context, listen: false).getCurrentRoom();
    double squareSize = miniMapSize / 4;
    double offsetConstant = 1.5 * squareSize;
    var mapOffset = Matrix4.translationValues(-(squareSize * currentRoom.x - offsetConstant), -(squareSize * currentRoom.y - offsetConstant), 0);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withAlpha(255).withOpacity(.7), width: 2),
        color: Color.fromRGBO(50, 50, 50, 0.7),
      ),
      height: miniMapSize,
      width: miniMapSize,
      child: InteractiveViewer(
        panEnabled: false,
        transformationController: TransformationController(mapOffset),
        boundaryMargin: EdgeInsets.all(offsetConstant),
        constrained: false,
        scaleEnabled: false,
        child: UnconstrainedBox(clipBehavior: Clip.hardEdge, child: drawGrid(squareSize, rooms)),
      ),
    );
  }

  Widget drawGrid(double roomSize, List<Room> rooms) {
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
}
