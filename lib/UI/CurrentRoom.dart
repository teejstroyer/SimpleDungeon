import 'package:SimpleDungeon/Domain/Entities/Entity.dart';
import 'package:SimpleDungeon/Providers/GameProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/DungeonProvider.dart';
import 'Shared/FancyButton.dart';

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
          child: FancyButton(
            color: entity.color,
            size: 45,
            horizontalPadding: 0,
            verticalPadding: 0,
            onPressed: () => Provider.of<GameProvider>(context, listen: false).setCurrentSelectedEntity(entity),
            child: Container(child: Center(child: LayoutBuilder(builder: (context, constraints) {
              return Icon(entity.icon, size: constraints.biggest.shortestSide);
            }))),
          ),
        ),
      );
    }

    return Column(children: grid);
  }
}

class EntityButton extends StatelessWidget {
  const EntityButton({
    Key key,
    @required this.entity,
  }) : super(key: key);

  final Entity entity;

  @override
  Widget build(BuildContext context) {
    double padding = 0;
    return FancyButton(
      color: entity.color,
      size: 45,
      horizontalPadding: padding,
      verticalPadding: padding,
      onPressed: () {
        Provider.of<GameProvider>(context).setCurrentSelectedEntity(entity);
      },
      child: Container(child: Center(child: LayoutBuilder(builder: (context, constraints) {
        return Icon(entity.icon, size: constraints.biggest.shortestSide);
      }))),
    );
  }
}
