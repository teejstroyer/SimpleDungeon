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
      int pRoll = _diceManager.roll(_player.selectedDie);
      int eRoll = _diceManager.roll(_currentEntity.selectedDie);
      // Don't allow any actions if the enemy is already dead
      // This is mostly as a first line of defense to prevent the reward popup showing multiple times
      // But also prevents a dead enemy from still dealing damage
      if (_currentEntity.health != 0) {
        print("Player Rolled $pRoll");
        // _damageEntity(pRoll);
        _damageEntity(100);
        // If the enemy was killed just now, show the reward
        // Must be placed here, or else the animation runtime will allow for the reward popup to
        //   display several times if the Attack button is spammed
        if (_currentEntity.health <= 0) {
          showRewardAlert(context);
        }
        await new Future.delayed(const Duration(seconds: 1));
        lastRoll = pRoll.toString();
        // Player roll, current selected die
        // Play Attack Animation
        // Should reduce entities health etc etc
        print("Entity Rolled $eRoll");
        _damagePlayer(eRoll);
        gameMessage = "${_currentEntity.name} rolled a $eRoll";
      }
    }
  }

  void showRewardAlert(BuildContext context) {
    Widget btnAccept = FlatButton(
      child: Text("Accept"),
      onPressed: () {
        // update the Player inventory
        // For testing, just do a player level +1
        _player.rewardType = _currentEntity.rewardType;
        _player.acceptReward();
        _player.rewardType = null;
        _currentEntity.rewardType = null;
        notifyListeners();
        Navigator.pop(context);
      },
    );
    Widget btnRefuse = FlatButton(
      child: Text("Refuse"),
      onPressed: () {
        // Take no action and close the alert
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Reward"),
      content: Text("For killing the ${_currentEntity.name}, you have received: ${_currentEntity.rewardType}"),
      actions: [btnAccept, btnRefuse],
    );

    showDialog(context: context, builder: (context) => alert, barrierDismissible: false);
  }
}
