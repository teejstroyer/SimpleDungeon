import 'package:SimpleDungeon/CurrentRoom.dart';
import 'package:flutter/material.dart';
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
              colors: [Colors.grey, Colors.deepOrange, Colors.deepPurple, Colors.black],
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                getPlayerStats(),
                getGameInfo(),
                getCenterView(),
                //Will be where game roll mechanic etc is
                Expanded(flex: 1, child: Container(color: Colors.red)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container getGameInfo() {
    return Container(
      padding: EdgeInsets.all(5),
      height: 100,
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

  Container getPlayerStats() {
    return Container(
      height: 75,
      color: Colors.amber,
      child: Center(child: Text('Player Stats')),
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
