import 'package:SimpleDungeon/CurrentRoom.dart';
import 'package:SimpleDungeon/GameProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DungeonProvider.dart';
import 'MiniMap.dart';
import 'MoveButton.dart';

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
                getGameInfo(),
                getCenterView(),
                //Will be where game roll mechanic etc is
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container getGameInfo() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 120,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(child: Container(color: Colors.green, child: Center(child: Text('Enemy Stats')))),
                Expanded(child: Container(color: Colors.blue, child: Center(child: Text('Game Messages')))),
              ],
            ),
          ),
          _getMiniMap()
        ],
      ),
    );
  }

  Widget getCenterView() {
    return Container(
      padding: EdgeInsets.only(top: 12, left: 9, right: 9, bottom: 3),
      child: LayoutBuilder(
        builder: (context, constraint) {
          var gameContainerSize = constraint.biggest.shortestSide;
          var gameCenterSize = constraint.biggest.shortestSide - 100;
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

  LayoutBuilder _getMiniMap() {
    return LayoutBuilder(builder: (context, constraint) {
      return MiniMap(
        miniMapSize: constraint.biggest.shortestSide,
      );
    });
  }
}

class PlayerStats extends StatelessWidget {
  const PlayerStats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var player = Provider.of<GameProvider>(context, listen: true).player;
    return Row(
      children: [
        CircleAvatar(child: Text(player.level.toString())),
        Container(
          height: 75,
          color: Colors.amber,
          child: Center(child: Text(player.attack.toString())),
        ),
      ],
    );
  }
}
