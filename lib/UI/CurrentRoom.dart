import 'package:simple_dungeon/Domain/Room.dart';
import 'package:simple_dungeon/Providers/GameProvider.dart';
import 'package:simple_dungeon/UI/EntityButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var room = context.select<GameProvider, Room>((p) => p.currentRoom);
    var grid = <Expanded>[];
    List<List<Expanded>> rows = [<Expanded>[]];
    int rowSum = 0;
    var avgPriority = room.entities.fold(1, (previousValue, element) => previousValue + element.priority) / room.entityCount;

    for (int i = 0; i < room.entities.length; i++) {
      rowSum += room.entities[i].priority;
      rows[rows.length - 1].add(
        Expanded(
          flex: room.entities[i].priority,
          child: EntityButton(entity: room.entities[i]),
        ),
      );

      if (i == room.entityCount - 1 || rowSum >= avgPriority * 3) {
        grid.add(Expanded(
          flex: rowSum ~/ rows[rows.length - 1].length,
          child: Row(children: rows[rows.length - 1]),
        ));
        rowSum = 0;
        rows.add(<Expanded>[]);
      }
    }

    return Column(children: grid);
  }
}
