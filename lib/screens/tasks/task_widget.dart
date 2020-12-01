import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';

class TaskWidget extends StatelessWidget {
  final Task _task;
  final Function(String) _onChanged;
  final Function(String) _onHasNotFocus;

  TaskWidget(this._task, this._onChanged, this._onHasNotFocus);

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController(text: _task.name);

    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      width: double.maxFinite,
      child: Focus(
        onFocusChange: (hasFocus) {
          if (!hasFocus) {
            _onHasNotFocus(textController.text);
          }
        },
        child: TextField(
          controller: textController,
          onChanged: _onChanged,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
              border: InputBorder.none
          ),
        ),
      )
    );
  }
}