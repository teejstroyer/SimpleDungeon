import 'package:SimpleDungeon/Domain/Entities/Entity.dart';
import 'package:SimpleDungeon/Providers/GameProvider.dart';
import 'package:SimpleDungeon/UI/CurrentRoom.dart';
import 'package:SimpleDungeon/UI/Shared/HealthBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/DungeonProvider.dart';
import 'MiniMap.dart';
import 'MoveButton.dart';
import 'PlayerStats.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepPurple.shade800, Colors.deepPurple.shade400, Colors.deepPurple.shade900],
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                PlayerStats(),
                GameInfo(),
                Expanded(child: getCenterView()),
                FlatButton(
                    onPressed: () => Provider.of<GameProvider>(context, listen: false).damageEntity(),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.remove,
                        size: 150,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCenterView() {
    return Container(
      child: LayoutBuilder(
        builder: (context, constraint) {
          var gameContainerSize = constraint.biggest.shortestSide * .95;
          var gameCenterSize = constraint.biggest.shortestSide * .65;
          return Center(
            child: Container(
              width: gameContainerSize,
              height: gameContainerSize,
              child: Column(
                children: [
                  MoveButton(direction: Direction.UP),
                  Container(
                    height: gameCenterSize,
                    child: Row(
                      children: [
                        MoveButton(direction: Direction.LEFT),
                        Container(
                          height: gameCenterSize,
                          width: gameCenterSize,
                          child: CurrentRoom(),
                        ),
                        MoveButton(direction: Direction.RIGHT),
                      ],
                    ),
                  ),
                  MoveButton(direction: Direction.DOWN)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class GameInfo extends StatelessWidget {
  const GameInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 120,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                EntityInfo(),
                Expanded(child: Container(color: Colors.blue, child: Center(child: Text('Game Messages')))),
              ],
            ),
          ),
          _getMiniMap()
        ],
      ),
    );
  }

  LayoutBuilder _getMiniMap() {
    return LayoutBuilder(builder: (context, constraint) {
      return MiniMap(
        miniMapSize: constraint.biggest.shortestSide,
      );
    });
  }
}

class EntityInfo extends StatelessWidget {
  const EntityInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Entity selectedEntity = Provider.of<GameProvider>(context).getCurrentSelectedEntity();
    return Expanded(
      child: Container(
        color: Colors.white,
        child: selectedEntity == null
            ? null
            : Column(
                children: [
                  Row(
                    children: [
                      Text(selectedEntity == null ? "" : selectedEntity.entityType.toString()),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 2, right: 2),
                          height: 10,
                          child: HealthBar(
                            currentHealth: selectedEntity.health,
                            maxHealth: selectedEntity.maxHealth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}