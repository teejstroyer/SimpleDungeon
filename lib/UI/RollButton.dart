import 'package:flutter/material.dart';
import 'package:simple_dungeon/Domain/Entities/Entity.dart';
import 'package:simple_dungeon/Providers/GameProvider.dart';
import 'package:provider/provider.dart';
import 'package:simple_dungeon/UI/Shared/SpinningButton.dart';

class RollButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(this);
    var canRoll = context.select<GameProvider, bool>((g) => g.playerCanRoll);
    var selectedEntity = context.select<GameProvider, Entity>((g) => g.currentSelectedEntity);

    return SpinningButton(
      onPress: !canRoll || selectedEntity == null ? null : () => roll(context),
      child: Container(
        color: Colors.pink,
        height: 80,
        width: 80,
        child: Center(child: Text(context.select<GameProvider, String>((g) => g.lastRoll))),
      ),
    );
  }

  void roll(BuildContext context) async {
    context.read<GameProvider>().playTurn();
    var selectedEntity = context.read<GameProvider>().currentSelectedEntity;
    if (selectedEntity.health <= 0) {
      await buildShowGeneralDialog(context);
    }
    context.read<GameProvider>().playerCanRoll = true;
  }

  Future<Object> buildShowGeneralDialog(BuildContext context) {
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 400,
            child: SizedBox.expand(child: FlutterLogo()),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(position: Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(anim1), child: child);
      },
    );
  }
}
