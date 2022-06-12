import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HoldValueExample extends StatelessWidget {
  const HoldValueExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(milliseconds: 3000)),
        builder: (context, snapshot) {
          Future.microtask(() => {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Rebuild"),
                  duration: Duration(seconds: 1),
                ))
              });

          return ChangeNotifierProvider(
              create: (BuildContext context) {
                return NumberProvider();
              },
              child: Consumer<NumberProvider>(
                  builder: (_, NumberProvider numberProvider, ___) => ElevatedButton(
                        child: Text('${numberProvider.number}'),
                        onPressed: () => numberProvider,
                      )));
        });
  }
}

class NumberProvider extends ChangeNotifier {
  int number = 0;

  void add() {
    number++;
    notifyListeners();
  }
}
