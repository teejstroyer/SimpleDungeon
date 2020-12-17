import 'package:simple_dungeon/Providers/DungeonProvider.dart';
import 'package:simple_dungeon/Providers/GameProvider.dart';
import 'package:simple_dungeon/UI/Shared/FancyButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoveButton extends StatelessWidget {
  final Direction direction;
  const MoveButton({Key key, this.direction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this);
    bool enabled = context.select<DungeonProvider, bool>((d) => d.isDirectionAvailable(direction));
    IconData icon;
    switch (direction) {
      case Direction.LEFT:
        icon = Icons.keyboard_arrow_left;
        break;
      case Direction.RIGHT:
        icon = Icons.keyboard_arrow_right;
        break;
      case Direction.UP:
        icon = Icons.keyboard_arrow_up;
        break;
      case Direction.DOWN:
        icon = Icons.keyboard_arrow_down;
        break;
    }

    return Expanded(
      child: FancyButton(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(child: Center(child: Icon(icon, size: constraints.biggest.shortestSide, color: Color.fromARGB(100, 0, 0, 0))));
          },
        ),
        size: 50,
        color: enabled ? Colors.red : Colors.grey,
        horizontalPadding: 5,
        verticalPadding: 5,
        onPressed: enabled
            ? () {
                context.read<DungeonProvider>().moveInDirection(direction);
                context.read<GameProvider>().currentSelectedEntity = null;
              }
            : () => null,
        disabled: !enabled,
      ),
    );
  }
}
