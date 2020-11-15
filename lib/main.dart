import 'dart:math';

import 'package:SimpleDungeon/Dungeon.dart';
import 'package:flutter/material.dart';

void main() {
  var dung = Dungeon();
  dung.generate(10);
  //dung.rooms[Random().nextInt(dung.rooms.length)].current = true;
  dung.rooms[Random().nextInt(dung.rooms.length)].visited = true;

  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: getMiniMap(dung, 20),
        ),
      ),
    ),
  );
}

Container getMiniMap(Dungeon dung, double squareSize) {
  var currentRoom = dung.rooms.any((i) => i.current) ? dung.rooms.firstWhere((element) => element.current) : dung.rooms.first;
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
      child: UnconstrainedBox(clipBehavior: Clip.hardEdge, child: dung.drawGrid(squareSize)),
    ),
  );
}
