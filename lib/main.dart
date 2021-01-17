import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/Game.dart';
import 'Providers/GameProvider.dart';

void main() {
  runApp(
    MultiProvider(
      child: Game(),
      providers: [
        ChangeNotifierProvider(create: (context) => GameProvider()),
      ],
    ),
  );
}
