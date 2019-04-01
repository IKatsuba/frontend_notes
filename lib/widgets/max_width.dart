import 'package:flutter/material.dart';

class MaxWidth extends StatelessWidget {
  final Widget child;

  final double maxWidth;

  MaxWidth({Key key, this.child, this.maxWidth = 500.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
