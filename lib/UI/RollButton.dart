import 'package:flutter/material.dart';
import 'package:simple_dungeon/Domain/Entities/Entity.dart';
import 'package:simple_dungeon/Providers/GameProvider.dart';
import 'package:provider/provider.dart';
import 'package:simple_dungeon/UI/Shared/SpinningButton.dart';

class RollButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var canRoll = context.select<GameProvider, bool>((g) => g.playerCanRoll);
    var selectedEntity = context.select<GameProvider, Entity>((g) => g.currentSelectedEntity);
    double size = 80;

    return SpinningButton(
      onPress: !canRoll || selectedEntity == null ? null : () => roll(context),
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(focalRadius: size / 2, colors: [Colors.white, Colors.grey]),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: Colors.black,
            width: 5,
          ),
        ),
        height: size,
        width: size,
        child: FittedBox(
          alignment: Alignment.center,
          fit: BoxFit.contain,
          child: Text(
            context.select<GameProvider, String>((g) => g.lastRoll),
            textAlign: TextAlign.center,
          ),
        ),
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
