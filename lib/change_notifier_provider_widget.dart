import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeNotifyProviderWidget extends StatelessWidget {
  const ChangeNotifyProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ColorChangeNotifierProvider>(
      create: (_) => ColorChangeNotifierProvider(),
      child: Builder(builder: (context) {
        var colorProvider = Provider.of<ColorChangeNotifierProvider>(context);
        return ElevatedButton(
            onPressed: () {
              colorProvider.changeRandomColor();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Change ColorProvider Color"),
              ));
            },
            child: const Text('ChangeNotifierProvider'),
            style: ElevatedButton.styleFrom(primary: colorProvider.color));
      }),
    );
  }
}

class ColorChangeNotifierProvider extends ChangeNotifier {
  ColorChangeNotifierProvider();

  Color color = Colors.blue;

  void changeRandomColor() {
    color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    notifyListeners();
  }
}
