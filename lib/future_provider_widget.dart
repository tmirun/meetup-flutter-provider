import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FutureProviderWidget extends StatelessWidget {
  const FutureProviderWidget({Key? key}) : super(key: key);

  Future<Color> fetchColor() {
    return Future.delayed(const Duration(milliseconds: 3000), () {
      return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider<Color>(
      initialData: Colors.black,
      create: (_) => fetchColor(),
      child: Builder(builder: (context) {
        var color = Provider.of<Color>(context);
        return ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Fetch Provider"),
              ));
            },
            child: const Text('FutureProviderWidget will change color un 2s'),
            style: ElevatedButton.styleFrom(primary: color));
      }),
    );
  }
}
