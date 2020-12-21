import 'package:flutter/material.dart';

class HealthBar extends StatelessWidget {
  const HealthBar({
    Key key,
    this.currentHealth,
    this.maxHealth,
    this.healthColor = Colors.green,
    this.noHealthColor = Colors.red,
    this.height,
    this.width,
    this.textColor = Colors.black,
  }) : super(key: key);

  final double height;
  final double width;
  final int currentHealth;
  final int maxHealth;
  final Color healthColor;
  final Color noHealthColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    if (maxHealth <= 0) return Container();
    int cw = ((currentHealth / maxHealth) * 100).toInt();
    return Container(
      height: height,
      width: width,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Row(
            children: [
              Expanded(flex: cw, child: Container(color: healthColor)),
              Expanded(flex: 100 - cw, child: Container(color: noHealthColor)),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(left: 2),
              child: FittedBox(
                child: Text(
                  '$currentHealth/$maxHealth',
                  style: TextStyle(color: textColor),
                ),
              )),
        ],
      ),
    );
  }
}
