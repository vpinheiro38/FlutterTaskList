import 'package:flutter/material.dart';
import 'package:task_app/style.dart';

class AddButton extends StatelessWidget {
  final Function() _onTap;

  AddButton(this._onTap);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(20),
          child: Icon(Icons.add, color: TextColor),
        ),
      )
    );
  }

}