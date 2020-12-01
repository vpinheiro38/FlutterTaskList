import 'package:flutter/material.dart';
import 'package:task_app/style.dart';

class PageScaffold extends StatelessWidget {
  final Widget _child;

  PageScaffold(this._child);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: SafeArea(
        child: _child,
      ),
    );
  }

}