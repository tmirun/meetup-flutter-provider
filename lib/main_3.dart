import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyWidget(),
  ));
}

class MyWidget extends StatefulWidget {
  const MyWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorInfo(color,
          child: Container(
            child: Container(
              child: Column(
                children: const [
                  ColorConsumer(),
                  NotColorConsumer(),
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
          });
        },
      ),
    );
  }
}

class ColorInfo extends InheritedWidget {
  const ColorInfo(
    this.color, {
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final Color color;

  static ColorInfo of(BuildContext context) {
    final ColorInfo? result = context.dependOnInheritedWidgetOfExactType<ColorInfo>();
    assert(result != null, 'No ColorInco found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ColorInfo old) {
    return old.color != color;
  }
}

// 这个消费 ColorInfo 里面的 color
class ColorConsumer extends StatelessWidget {
  const ColorConsumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorInfo colorInfo = context.dependOnInheritedWidgetOfExactType<ColorInfo>() as ColorInfo;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("build ColorConsumer"),
    ));
    return Expanded(child: Container(color: colorInfo.color));
  }
}

// 这个不消费 ColorInfo 里面的 color
class NotColorConsumer extends StatelessWidget {
  const NotColorConsumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("build NotColorConsumer"),
    ));
    return Expanded(child: Container());
  }
}
