import 'package:flutter/material.dart';
import './fn_title.dart';
import '../enums/enums.dart';
import './fn_bar.dart';

class FnDrawer extends StatefulWidget {
  @override
  _FnDrawerState createState() => _FnDrawerState();
}

class _FnDrawerState extends State<FnDrawer> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Theme(
      isMaterialAppTheme: true,
      data: themeData.copyWith(canvasColor: themeData.scaffoldBackgroundColor),
      child: Drawer(
        child: Column(
          children: <Widget>[
            FnBar(
              automaticallyImplyLeading: false,
              title: FnTitle(),
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
      ),
    );
  }
}
