import 'package:flutter/material.dart';
import 'Player.dart';

class GameProvider extends ChangeNotifier {
  Player _player;
  GameProvider() {
    _player = new Player();
  }

  Player get player => _player;
}
