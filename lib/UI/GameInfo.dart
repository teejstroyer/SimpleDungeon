import 'package:simple_dungeon/UI/EntityInfo.dart';
import 'package:simple_dungeon/UI/GameMessage.dart';
import 'package:simple_dungeon/UI/MiniMap.dart';
import 'package:flutter/material.dart';

class GameInfo extends StatelessWidget {
  const GameInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 125;
    return Container(
      height: size,
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              EntityInfo(),
              GameMessage(),
            ],
          ),
        ),
        MiniMap(miniMapSize: size)
      ]),
    );
  }
}
