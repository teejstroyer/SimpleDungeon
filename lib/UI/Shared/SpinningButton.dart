import 'dart:math';
import 'package:flutter/material.dart';

class SpinningButton extends StatefulWidget {
  final Widget child;
  final Function onPress;

  const SpinningButton({Key key, this.onPress, this.child}) : super(key: key);

  @override
  _SpinningButtonState createState() => _SpinningButtonState();
}

class _SpinningButtonState extends State<SpinningButton> with SingleTickerProviderStateMixin {
  double _angle;
  AnimationController _controller;

  _SpinningButtonState();
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      //lowerBound: 0.0,
      upperBound: 2 * pi,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _angle = _controller.value;
    return Center(
      child: GestureDetector(
        onTapDown: _tapDown,
        onTapUp: (TapUpDetails t) {
          _tapUp(t, context);
          widget.onPress();
        },
        child: Transform.rotate(
          angle: _angle,
          child: widget.child,
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details, BuildContext context) {
    _controller.reverse();
  }
}
