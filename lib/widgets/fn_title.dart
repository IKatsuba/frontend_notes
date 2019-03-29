import 'package:flutter/material.dart';

class FnTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Text(
          'Frontend',
          style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
              fontWeight: FontWeight.w400),
        ),
        Text('Notes'),
      ],
    );
  }
}
