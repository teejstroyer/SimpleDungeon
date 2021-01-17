import 'package:simple_dungeon/Providers/DungeonProvider.dart';
import 'package:simple_dungeon/Providers/GameProvider.dart';
import 'package:simple_dungeon/UI/CurrentRoom.dart';
import 'package:simple_dungeon/UI/GameInfo.dart';
import 'package:simple_dungeon/UI/MoveButton.dart';
import 'package:simple_dungeon/UI/PlayerStats.dart';
import 'package:flutter/material.dart';
import 'package:simple_dungeon/UI/RollButton.dart';
import 'package:provider/provider.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.deepPurple.shade900,
                Colors.deepPurple.shade500,
                Colors.deepPurple.shade900,
              ],
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: SafeArea(
            child: Column(
              //mainAxisSize: ,
              children: [
                PlayerStats(),
                GameInfo(),
                Expanded(child: GameBoard()),
                Container(child: RollButton(), padding: EdgeInsets.all(5)),

                //Temporary for testing
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.orangeAccent,
                        height: 130,
                        child: FlatButton(
                          child: Text('HURT ME'),
                          onPressed: () => context.read<GameProvider>().damagePlayer(10),
                          onLongPress: () => context.read<GameProvider>().damagePlayer(1000),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.greenAccent,
                        height: 130,
                        child: FlatButton(
                          child: Text('HEAL ME'),
                          onPressed: () => context.read<GameProvider>().damagePlayer(-10),
                          onLongPress: () => context.read<GameProvider>().damagePlayer(-1000),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.greenAccent,
                        height: 130,
                        child: FlatButton(
                          child: Text('HURT IT'),
                          onPressed: () => context.read<GameProvider>().damageEntity(10),
                          onLongPress: () => context.read<GameProvider>().damageEntity(1000),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.orangeAccent,
                        height: 130,
                        child: FlatButton(
                          child: Text('HEAL IT'),
                          onPressed: () => context.read<GameProvider>().damageEntity(-10),
                          onLongPress: () => context.read<GameProvider>().damageEntity(-100),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameBoard extends StatelessWidget {
  const GameBoard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
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
