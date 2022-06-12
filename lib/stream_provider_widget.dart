import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StreamProviderWidget extends StatelessWidget {
  StreamProviderWidget({Key? key}) : super(key: key);

  final StreamController<Color> colorStreamController = StreamController();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Color>(
      initialData: Colors.lightBlueAccent,
      create: (_) => colorStreamController.stream,
      child: Builder(builder: (context) {
        var color = Provider.of<Color>(context);
        return ElevatedButton(
            onPressed: () {
              color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
              colorStreamController.add(color);
            },
            child: const Text('ChangeNotifierProvider'),
            style: ElevatedButton.styleFrom(primary: color));
      }),
    );
  }
}
