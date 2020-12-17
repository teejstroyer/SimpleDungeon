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
    print(this);
    Entity selectedEntity = context.select<GameProvider, Entity>((g) => g.currentSelectedEntity);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(.7), width: 2),
          color: Color.fromRGBO(50, 50, 50, 0.7),
        ),
        padding: EdgeInsets.all(3),
        child: selectedEntity == null
            ? null
            : Column(
                children: [
                  Row(
                    children: [
                      Text(
                        selectedEntity == null ? "" : selectedEntity.name + ": ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 2, right: 2),
                          height: 10,
                          child: HealthBar(
                            currentHealth: selectedEntity.health,
                            maxHealth: selectedEntity.maxHealth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
