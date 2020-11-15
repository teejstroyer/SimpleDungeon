import 'dart:math';

import 'package:SimpleDungeon/Dungeon.dart';
import 'package:flutter/material.dart';

void main() {
  var dung = Dungeon();
  dung.generate(10);
  dung.rooms[Random().nextInt(dung.rooms.length)].current = true;
  dung.rooms[Random().nextInt(dung.rooms.length)].visited = true;
  var squareSize = 90.0;
  var currentRoom = dung.rooms.firstWhere((element) => element.current);
  var mapOffset = Matrix4.translationValues(-(squareSize * currentRoom.x - squareSize / 2), -(squareSize * currentRoom.y - squareSize / 2), 0);

  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black), color: Colors.transparent),
              height: 200,
              width: 200,
              child: InteractiveViewer(
                transformationController: TransformationController(mapOffset),
                boundaryMargin: EdgeInsets.all(0),
                constrained: false,
                scaleEnabled: true,
                minScale: 0.01,
                maxScale: 4,
                child: UnconstrainedBox(clipBehavior: Clip.hardEdge, child: dung.drawGrid(squareSize)),
              )),
        ),
      ),
    ),
  );
}
