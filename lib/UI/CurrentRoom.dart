import 'package:simple_dungeon/Domain/Room.dart';
import 'package:simple_dungeon/UI/EntityButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/DungeonProvider.dart';

class CurrentRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(this);
    var room = context.select<DungeonProvider, Room>((p) => p.getCurrentRoom());
    var grid = List<Expanded>();
    List<List<Expanded>> rows = [List<Expanded>()];
    int rowSum = 0;

    for (var entity in room.entities) {
      if (rowSum >= room.entityCount) {
        grid.add(Expanded(
          flex: rowSum ~/ rows[rows.length - 1].length,
          child: Row(children: rows[rows.length - 1]),
        ));
        rowSum = 0;
        rows.add(List<Expanded>());
      }
      rowSum += entity.priority;
      rows[rows.length - 1].add(
        Expanded(flex: entity.priority, child: EntityButton(entity: entity)),
      );
    }

    return Column(children: grid);
  }
}
