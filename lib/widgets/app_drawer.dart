import 'package:flutter/material.dart';
import './app_title.dart';
import '../enums/enums.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: AppTitle(),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(Routes.About);
            },
          ),
          Divider(
            height: 0,
          )
        ],
      ),
    );
  }
}
