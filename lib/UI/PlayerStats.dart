import 'package:SimpleDungeon/Providers/GameProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Shared/HealthBar.dart';

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
        HealthBar(
          height: 20,
          width: 100,
          currentHealth: player.health,
          maxHealth: player.maxHealth,
        )
      ],
    );
  }
}
