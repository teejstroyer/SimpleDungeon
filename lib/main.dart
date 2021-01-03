import 'package:simple_dungeon/Providers/DungeonProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/Game.dart';
import 'Providers/GameProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  // Need to run this line to prevent error when getting documents dir
  // Requred when running async funcs in main()
  WidgetsFlutterBinding.ensureInitialized();

  // runApp(
  //   MultiProvider(
  //     child: Game(),
  //     providers: [
  //       ChangeNotifierProvider(create: (context) => DungeonProvider()),
  //       ChangeNotifierProvider(create: (context) => GameProvider()),
  //     ],
  //   ),
  // );
  // return;
  getApplicationDocumentsDirectory().then((documentsDirectory) {
    var saveFile = File(documentsDirectory.path + "/SimpleDungeonData.txt");
    // Make sure save file already exists
    if (!saveFile.existsSync()) {
      print("No existing save file");
      saveFile.createSync();
      return;
    }

    var appDataString = saveFile.readAsStringSync();
    var appData = jsonDecode(appDataString);

    var dungeonProvider = DungeonProvider.fromJson(appData["dungeon"]);
    var gameProvider = GameProvider.fromJson(appData["game"]);
    runApp(
      MultiProvider(
        child: Game(),
        providers: [
          ChangeNotifierProvider(create: (context) => dungeonProvider),
          ChangeNotifierProvider(create: (context) => gameProvider),
        ],
      ),
    );
  }).catchError((error) {
    print("Error getting documents directory");

    runApp(
      MultiProvider(
        child: Game(),
        providers: [
          ChangeNotifierProvider(create: (context) => DungeonProvider()),
          ChangeNotifierProvider(create: (context) => GameProvider()),
        ],
      ),
    );
  });
}
