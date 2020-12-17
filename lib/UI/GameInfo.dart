import 'package:simple_dungeon/Providers/GameProvider.dart';
import 'package:simple_dungeon/UI/EntityInfo.dart';
import 'package:simple_dungeon/UI/MiniMap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameInfo extends StatelessWidget {
  const GameInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this);
    return Container(
      padding: EdgeInsets.all(10),
      height: 150,
      child: Row(children: [
        Expanded(
          child: Column(
            children: [
              EntityInfo(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withAlpha(255).withOpacity(.7), width: 2),
                    color: Color.fromRGBO(50, 50, 50, 0.7),
                  ),
                  child: Center(
                    child: Text(
                      context.select<GameProvider, String>((g) => g.gameMessage) ?? "",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _getMiniMap()
      ]),
    );
  }

  LayoutBuilder _getMiniMap() => LayoutBuilder(
      builder: (context, constraint) => MiniMap(
            miniMapSize: constraint.biggest.shortestSide,
          ));
}
