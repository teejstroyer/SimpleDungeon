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
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 75,
                color: Colors.amber,
                child: Center(child: Text('Player Stats')),
              ),
              Container(
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
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: LayoutBuilder(
                    builder: (context, constraint) {
                      var gameContainerSize = constraint.biggest.shortestSide;
                      var gameCenterSize = constraint.biggest.shortestSide - 100;
                      return Center(
                        child: Container(
                          color: Colors.orange,
                          width: gameContainerSize,
                          height: gameContainerSize,
                          child: Column(children: [
                            MoveButton(direction: Direction.UP),
                            Container(
                              height: gameCenterSize,
                              child: Row(
                                children: [
                                  MoveButton(direction: Direction.LEFT),
                                  Container(
                                    height: constraint.biggest.shortestSide - 10,
                                    width: gameCenterSize,
                                    child: CurrentRoom(),
                                  ),
                                  MoveButton(direction: Direction.RIGHT),
                                ],
                              ),
                            ),
                            MoveButton(direction: Direction.DOWN)
                          ]),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container(color: Colors.red)),
            ],
          ),
        ),
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
