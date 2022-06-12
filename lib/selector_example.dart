import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class SelectorExample extends StatelessWidget {
  const SelectorExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NumberProvider(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Selector<NumberProvider, int>(
              selector: (_, provider) => provider.number1,
              builder: (context, number1, child) {
                var numberProvider = Provider.of<NumberProvider>(context);
                Future.microtask(() => {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Rebuild selector 1"),
                        duration: Duration(seconds: 1),
                      ))
                    });
                return ElevatedButton(
                    onPressed: () => numberProvider.addTo1(), child: Text('SELECTOR numer1: $number1'));
              }),
          const SizedBox(height: 10),
          Selector<NumberProvider, int>(
              selector: (_, provider) => provider.number2,
              builder: (context, number2, child) {
                var numberProvider = Provider.of<NumberProvider>(context);
                Future.microtask(() => {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Rebuild selector 2"),
                        duration: Duration(seconds: 1),
                      ))
                    });
                return ElevatedButton(
                    onPressed: () => numberProvider.addTo2(), child: Text('SELECTOR numer2: $number2'));
              }),
          const SizedBox(height: 10),
          Selector<NumberProvider, Tuple2<int, int>>(
              selector: (_, provider) => Tuple2(provider.number1, provider.number2),
              builder: (context, data, child) {
                var numberProvider = Provider.of<NumberProvider>(context);
                Future.microtask(() => {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Rebuild multi selector"),
                        duration: Duration(seconds: 1),
                      ))
                    });
                return ElevatedButton(
                    onPressed: () => numberProvider.addToBoth(),
                    child: Text('MULTI-SELECTOR \n numer1: ${data.item1} \n numer2: ${data.item2}'));
              })
        ],
      ),
    );
  }
}

class NumberProvider extends ChangeNotifier {
  int _number1 = 0;
  int _number2 = 0;

  int get number1 => _number1;

  int get number2 => _number2;

  void addToBoth() {
    _number1++;
    _number2++;
    notifyListeners();
  }

  void addTo1() {
    _number1++;
    notifyListeners();
  }

  void addTo2() {
    _number2++;
    notifyListeners();
  }
}
