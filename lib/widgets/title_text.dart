import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String _text;

  TitleText(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Text(_text, style: Theme.of(context).textTheme.headline1)
    );
  }

}