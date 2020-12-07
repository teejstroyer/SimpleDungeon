import 'package:simple_dungeon/Domain/Entities/Entity.dart';
import 'package:simple_dungeon/Providers/GameProvider.dart';
import 'package:simple_dungeon/UI/Shared/FancyButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntityButton extends StatelessWidget {
  const EntityButton({Key key, @required this.entity}) : super(key: key);
  final Entity entity;

  @override
  Widget build(BuildContext context) {
    double padding = 0;
    return FancyButton(
      color: entity.color,
      size: 45,
      horizontalPadding: padding,
      verticalPadding: padding,
      onPressed: () => context.read<GameProvider>().currentSelectedEntity = entity,
      child: entityIcon(),
    );
  }

  Widget entityIcon() => Container(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) => Icon(
              entity.icon,
              size: constraints.biggest.shortestSide,
            ),
          ),
        ),
      );
}
