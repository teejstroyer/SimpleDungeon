import 'package:SimpleDungeon/Entitiy.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Room {
  int x;
  int y;
  bool current = false;
  bool visited = false;
  int size; //Size is one side of square. Total Spaces is Size Squared
  List<Entity> entities;

  Room(x, y, size) {
    this.x = x;
    this.y = y;
    this.size = size;
    generateEntities(false);
  }

  // We will generate all rooms, then double back to place boss
  void generateEntities(bool hasBoss) {
    // Generate list of entities of length (size^2)/2 rounded up
    // Dont think I need to do a full size^2 number of entities,
    //   so I figure a nice middle ground will work to keep the rooms nicely diverse and full without a lot of overflow

    List<Entity> entityList = new List<Entity>();
    for (int i = 0; i < pow(size, 2); i++) {
      var entity = Entity();
      entity.entityType = EntityType.Chest;
      entity.priority = Random().nextInt(10);
      entityList.add(entity);
    }
    this.entities = entityList;
  }

  // Return the tappable grid widget for the room
  Container renderRoom() {
// check dims and make cutoffs by row as summations of priority values are beneath row width
// then use priority as a ratios for width of entity
// use Expanded Widgets
    var strRow = "";
    var row = List<Expanded>();
    var grid = List<Expanded>();
    var width = 0;
    print("made it to render $this.entities.length");
    for (var item in this.entities) {
      var weight = item.priority + 1;
      if (width + weight <= 10) {
        width += weight;
        strRow += weight.toString() + " ";
        // expanded column
        row.add(Expanded(
          flex: weight,
          child: Container(
            color: randomColor(),
            child: Center(
              child: Text(weight.toString()),
            ),
          ),
        ));
      } else {
        var avg = (width / row.length).round();
        grid.add(Expanded(
          flex: avg, // this needs to be the average width
          child: Row(
            children: row,
          ),
        ));
        width = weight;
        print(strRow);
        print("average $avg");
        strRow = weight.toString() + " ";
        row = [
          Expanded(
            flex: weight,
            child: Container(
              color: randomColor(),
              child: Center(
                child: Text(weight.toString()),
              ),
            ),
          )
        ];
      }
    }

    return Container(
      height: 500,
      width: 500,
      child: Column(
        children: grid,
      ),
    );
  }

  Color randomColor() => Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}
