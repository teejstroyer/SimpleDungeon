import 'package:SimpleDungeon/DungeonProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Game.dart';

void main() {
  runApp(
    MultiProvider(
      child: new Game(),
      providers: [
        ChangeNotifierProvider(create: (context) => DungeonProvider()),
      ],
    ),
  );
}
