import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  var colorProvider = ColorProvider();

  print('initialized color ${colorProvider.color}');

  void listener1() {
    print('listener 1: ${colorProvider.color}');
  }

  colorProvider.addListener(listener1);

  colorProvider.changeRandomColor();
  colorProvider.changeRandomColor();

  colorProvider.removeListener(listener1);
  colorProvider.changeRandomColor();

  colorProvider.dispose();
  colorProvider.changeRandomColor(); // will throw error

  // flutter: initialized color MaterialColor(primary value: Color(0xfff44336))
  // flutter: listener 1: Color(0xff588cf0)
  // flutter: listener 1: Color(0xff40e480)
  // [ERROR:flutter/lib/ui/ui_dart_state.cc(209)] Unhandled Exception: A ColorProvider was used after being disposed.
  // Once you have called dispose() on a ColorProvider, it can no longer be used.
}

class ColorProvider extends ChangeNotifier {
  Color color = Colors.red;

  ColorProvider();

  void changeRandomColor() {
    color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    notifyListeners();
  }
}
