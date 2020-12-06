import 'package:SimpleDungeon/Domain/Dice.dart';
import 'package:SimpleDungeon/Domain/Entities/Entity.dart';
import 'package:SimpleDungeon/Domain/Entities/Player.dart';
import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  DiceManager _diceManager = new DiceManager();
  Entity _currentEntity;
  Player _player;
  String _lastRoll;
  String _gameMessage;

  Player get player => _player;
  String get lastRoll => _lastRoll;
  String get gameMessage => _gameMessage;
  Entity get currentSelectedEntity => _currentEntity;

  set gameMessage(String message) {
    _gameMessage = message;
    notifyListeners();
  }

  set currentSelectedEntity(Entity entity) {
    _currentEntity = entity;
    notifyListeners();
  }

  set lastRoll(String roll) {
    _lastRoll = roll;
    notifyListeners();
  }

  GameProvider() {
    _player = new Player();
    _lastRoll = "Roll";
  }

  void _damageEntity(int damage) {
    if (_currentEntity != null) {
      _currentEntity.takeDamage(damage);
      notifyListeners();
    }
  }

  void _damagePlayer(int damage) {
    _player.takeDamage(damage);
    notifyListeners();
  }

  void playTurn(BuildContext context) async {
    // Play Dice Roll Animation
    if (_currentEntity != null) {
      int pRoll = _diceManager.roll(player.selectedDie);
      int eRoll = _diceManager.roll(_currentEntity.selectedDie);
      print("Player Rolled $pRoll");
      // _damageEntity(pRoll);
      _damageEntity(100);
      /* Have to do the death check here, or else the delay allows for the Attack button to be pressed 
      more than once. So either 
      1) The enemy doesn't get a counter-attack on death and the animation plays after the reward is handled
      2) This function is made synchronous
      3) The Attack button is disabled until this function is finished with the async execution
      */
      if (currentSelectedEntity.health <= 0) {
        showRewardAlert(context);
      }
      await new Future.delayed(const Duration(seconds: 1));
      lastRoll = pRoll.toString();
      // Player roll, current selected die
      // Play Attack Animation
      // Should reduce entities health etc etc
      print("Entity Rolled $eRoll");
      _damagePlayer(eRoll);
      gameMessage = "${currentSelectedEntity.name} rolled a $eRoll";
    }
  }

  void showRewardAlert(BuildContext context) {
    Widget btnAccept = FlatButton(
      child: Text("Accept"),
      onPressed: () {
        // update the Player inventory
      },
    );
    Widget btnRefuse = FlatButton(
      child: Text("Refuse"),
      onPressed: () {
        Navigator.pop(context);
      }, // Take no action and close the alert
    );

    AlertDialog alert = AlertDialog(
      title: Text("Reward"),
      content: Text("For killing the ${currentSelectedEntity.name}, you have recieved: "),
      actions: [btnAccept, btnRefuse],
    );

    showDialog(context: context, builder: (context) => alert, barrierDismissible: false);
  }
}
