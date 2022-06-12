import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SimpleProviderWidget extends StatelessWidget {
  const SimpleProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<ColorProvider>(
      create: (_) => ColorProvider(),
      child: Builder(builder: (context) {
        var colorProvider = Provider.of<ColorProvider>(context);
        return ElevatedButton(
            onPressed: () {
              colorProvider.changeRandomColor();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Change Color"),
              ));
            },
            child: const Text('Simple Provider'),
            style: ElevatedButton.styleFrom(primary: colorProvider.color));
      }),
    );
  }
}

class ColorProvider {
  ColorProvider();

  Color color = Colors.blue;

  void changeRandomColor() {
    color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }
}
