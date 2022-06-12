import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProxyProviderExample extends StatelessWidget {
  const ProxyProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => 1),
        ChangeNotifierProxyProvider<int, NumberProvider>(
            create: (context) => NumberProvider(0), update: (context, number, _) => NumberProvider(number)),
        ProxyProvider<NumberProvider, String>(update: (context, numberProvider, _) {
          return 'number is: ${numberProvider.number}';
        }),
      ],
      builder: (context, child) {
        var test = Provider.of<String>(context);
        var numberProvider = Provider.of<NumberProvider>(context);
        return Container(
          child: Column(
            children: [
              Text(test),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    numberProvider.add();
                  },
                  child: Text(numberProvider.number.toString()))
            ],
          ),
        );
      },
    );
  }
}

class NumberProvider extends ChangeNotifier {
  int number = 0;

  NumberProvider(int num) {
    number = num;
  }

  void add() {
    number++;
    notifyListeners();
  }
}
