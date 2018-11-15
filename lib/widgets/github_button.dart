import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset('assets/github.png'),
      onPressed: () {
        launch('https://github.com/IKatsuba/frontend_notes');
      },
    );
  }
}
