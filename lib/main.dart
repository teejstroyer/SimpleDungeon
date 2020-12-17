import 'package:simple_dungeon/Providers/DungeonProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/Game.dart';
import 'Providers/GameProvider.dart';

void main() {
  runApp(
    MultiProvider(
      child: Game(),
      providers: [
        ChangeNotifierProvider(create: (context) => DungeonProvider()),
        ChangeNotifierProvider(create: (context) => GameProvider()),
      ],
    ),
  );
}
