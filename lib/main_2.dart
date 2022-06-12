import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: MyWidget(Column(
        children: <Widget>[WidgetA(), WidgetB()],
      )),
    ),
  ));
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyWidget(Column(
      children: <Widget>[WidgetA(), WidgetB()],
    ));
  }
}

class MyWidget extends StatefulWidget {
  final Widget child;

  MyWidget(this.child);

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<MyWidget> {
  int tmpData = 0;
  @override
  Widget build(BuildContext context) {
    print('MyWidget build');
    return MyInherited(
      data: tmpData,
      child: Column(
        children: [
          widget.child,
          ElevatedButton(
            child: Text("Click me"),
            onPressed: () {
              setState(() {
                print('onPressed');
                tmpData += 1;
              });
            },
          ),
        ],
      ),
    );
  }
}

class MyInherited extends InheritedWidget {
  final int data;

  MyInherited({required this.data, required Widget child}) : super(child: child) {
    print('MyInherited construct');
  }

  @override
  bool updateShouldNotify(MyInherited oldWidget) {
    bool result = oldWidget.data != this.data;
    print('MyInherited updateShouldNotify result = $result');
    return false;
  }

  static MyInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInherited>() as MyInherited;
  }
}

class WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('WidgetA build');
    int data = MyInherited.of(context).data;
    return Text('WidgetA data = $data');
  }
}

class WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('WidgetB build');
    return Text('WidgetB');
  }
}
