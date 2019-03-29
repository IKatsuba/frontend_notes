import 'package:flutter/material.dart';
import 'package:frontend_notes/enums/enums.dart';

import 'fn_bar.dart';
import 'fn_title.dart';

class FnDrawer extends StatelessWidget {
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
            ),
          ],
        ),
      ),
    );
  }
}
