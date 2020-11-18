import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DungeonProvider.dart';

class CurrentRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var room = Provider.of<DungeonProvider>(context, listen: true).getCurrentRoom();
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
    return Column(children: grid);
  }

  Color randomColor() => Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}
