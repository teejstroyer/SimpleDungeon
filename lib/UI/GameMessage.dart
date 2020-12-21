import 'package:flutter/material.dart';
import 'package:simple_dungeon/Providers/GameProvider.dart';
import 'package:provider/provider.dart';

class GameMessage extends StatelessWidget {
  const GameMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Text(
              context.select<GameProvider, String>((g) => g.gameMessage) ?? "",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
