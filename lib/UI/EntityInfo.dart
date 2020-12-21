import 'package:simple_dungeon/Domain/Entities/Entity.dart';
import 'package:simple_dungeon/Providers/GameProvider.dart';
import 'package:simple_dungeon/UI/Shared/HealthBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntityInfo extends StatelessWidget {
  const EntityInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var entity = context.select<GameProvider, Entity>((g) => g.currentSelectedEntity);
    return Expanded(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: entity == null ? Container() : entityStats(context),
        ),
      ),
    );
  }

  Column entityStats(BuildContext context) {
    int health = context.select<GameProvider, int>((g) => g.currentSelectedEntity.health);
    int maxHealth = context.select<GameProvider, int>((g) => g.currentSelectedEntity.maxHealth);
    String name = context.select<GameProvider, String>((g) => g.currentSelectedEntity.name);
    return Column(
      children: [
        Row(
          children: [
            Text(name + ": ", style: TextStyle(color: Colors.black)),
            Expanded(
              child: HealthBar(height: 10, currentHealth: health, maxHealth: maxHealth),
            ),
          ],
        ),
      ],
    );
  }
}
