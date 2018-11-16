import 'package:flutter/material.dart';

class FnCard extends StatelessWidget {
  final Widget child;
  final bool isFirst;
  final bool isLast;

  FnCard({Key key, this.child, this.isFirst = false, this.isLast = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        margin: EdgeInsets.only(
            left: 4.0,
            right: 4.0,
            top: isFirst ? 8.0 : 1,
            bottom: isLast ? 8.0 : 1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(isFirst ? 16.0 : 0),
                bottom: Radius.circular(isLast ? 16.0 : 0))),
        child: child);
  }
}
