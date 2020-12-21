import 'package:simple_dungeon/Providers/GameProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_dungeon/UI/Shared/HealthBar.dart';

class PlayerStats extends StatelessWidget {
  final double fontSize;
  const PlayerStats({Key key, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 14;

    return Row(
      children: [
        CircleAvatar(child: Text(context.select<GameProvider, int>((g) => g.player.level).toString())),
        buildStat(context.select<GameProvider, int>((g) => g.player.attack).toString(), Icons.local_fire_department, size),
        buildStat(context.select<GameProvider, int>((g) => g.player.defense).toString(), Icons.shield, size),
        Expanded(
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: Container(
              height: 2.5 * size,
              child: Row(
                children: [
                  Icon(Icons.local_hospital, size: 2.5 * size),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 5),
                      child: HealthBar(
                        healthColor: Colors.black,
                        noHealthColor: Colors.grey,
                        textColor: Colors.white,
                        height: 2 * size,
                        currentHealth: context.select<GameProvider, int>((g) => g.player.health),
                        maxHealth: context.select<GameProvider, int>((g) => g.player.maxHealth),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Card buildStat(String stat, IconData icon, double size) {
    return Card(
      child: Column(
        children: [Text(stat, style: TextStyle(fontSize: size)), Icon(icon, size: 1.5 * size)],
      ),
    );
  }
}
