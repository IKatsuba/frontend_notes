import 'package:flutter/material.dart';
import './fn_title.dart';

class FnBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;
  final Widget leading;

  FnBar(
      {Key key,
      this.title,
      this.actions,
      this.automaticallyImplyLeading = true,
      this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        title: title ?? FnTitle(),
        actions: actions,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: automaticallyImplyLeading,
        leading: leading);
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
