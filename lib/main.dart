import 'dart:math';

import 'package:SimpleDungeon/Dungeon.dart';
import 'package:flutter/material.dart';

void main() {
  var dung = Dungeon();
  dung.generate(10);
  dung.rooms[Random().nextInt(dung.rooms.length)].current = true;
  dung.rooms[Random().nextInt(dung.rooms.length)].visited = true;

  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: dung.getMiniMap(20),
        ),
      ),
    ),
  );
}
