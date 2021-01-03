import 'dart:convert';
import 'dart:io';
import 'package:simple_dungeon/Providers/DungeonProvider.dart';
import 'package:simple_dungeon/Providers/GameProvider.dart';
import 'package:simple_dungeon/UI/CurrentRoom.dart';
import 'package:simple_dungeon/UI/GameInfo.dart';
import 'package:simple_dungeon/UI/MoveButton.dart';
import 'package:simple_dungeon/UI/PlayerStats.dart';
import 'package:flutter/material.dart';
import 'package:simple_dungeon/UI/RollButton.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class LifecycleWatcher extends StatefulWidget {
  @override
  _LifecycleWatcherState createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher> with WidgetsBindingObserver {
  @override
  void initState() {
    print("init lifecycle watcher");
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    print("disposing lifecycle watcher");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("state changed to $state");
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Game extends StatefulWidget {
  @override
  _Game createState() => _Game();
}

class _Game extends State<Game> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      // case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      //app is inactive when there's an overlay, phone call, PiP, any time the
      //app can't take input (focus is lost), but may not be in paused state
      case AppLifecycleState.detached:
        //technically means the app engine is running without a view, which
        //functionally means the app is closed
        // In any of these conditions, save the state of the game, just in case
        //  it does end up being shut down from a paused state
        getApplicationDocumentsDirectory().then((documentsDirectory) {
          var saveFile = File(documentsDirectory.path + "/SimpleDungeonData.txt");
          // Make sure save file already exists
          if (!saveFile.existsSync()) {
            saveFile.createSync();
          }
          // Now that we have guaranteed the save file exists, we can write to it
          var saveData = jsonEncode({
            "game": this.context.read<GameProvider>().toJson(),
            "dungeon": this.context.read<DungeonProvider>().toJson(),
          });

          saveFile.writeAsStringSync(saveData);
          print("file has been saved");
        });
        break;
      default:
        break;
    }
    print("app state has changed to $state");
  }

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
              colors: [Colors.deepPurple.shade900, Colors.deepPurple.shade500, Colors.deepPurple.shade900],
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
