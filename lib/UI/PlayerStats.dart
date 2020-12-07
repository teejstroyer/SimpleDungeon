import 'package:simple_dungeon/Providers/GameProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Shared/HealthBar.dart';

class PlayerStats extends StatelessWidget {
  final double fontSize;
  const PlayerStats({Key key, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var player = context.select((GameProvider g) => g.player);
    return Row(
      children: [
        CircleAvatar(child: Text(player.level.toString())),
        Container(
          height: 75,
          color: Colors.amber,
          child: Center(child: Text(player.attack.toString())),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            height: 20,
            child: HealthBar(
              height: 20,
              currentHealth: player.health,
              maxHealth: player.maxHealth,
            ),
          ),
        )
      ],
    );
  }
}
