import 'package:simple_dungeon/Providers/DungeonProvider.dart';
import 'package:simple_dungeon/Providers/GameProvider.dart';
import 'package:simple_dungeon/UI/CurrentRoom.dart';
import 'package:simple_dungeon/UI/GameInfo.dart';
import 'package:simple_dungeon/UI/MoveButton.dart';
import 'package:simple_dungeon/UI/PlayerStats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              colors: [Colors.deepPurple.shade900, Colors.deepPurple.shade500, Colors.deepPurple.shade900],
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                PlayerStats(),
                GameInfo(),
                getCenterView(),
                FlatButton(
                    onPressed: () => context.read<GameProvider>().playTurn(),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.orange,
                      child: Text(context.select((GameProvider g) => g.lastRoll)),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCenterView() {
    return Expanded(
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
