import 'package:flutter/material.dart';
import 'package:test_provider_flutter/future_provider_widget.dart';
import 'package:test_provider_flutter/hold_value_example.dart';
import 'package:test_provider_flutter/proxy_provider_widget.dart';
import 'package:test_provider_flutter/selector_example.dart';
import 'package:test_provider_flutter/simple_provider_widget.dart';
import 'package:test_provider_flutter/stream_provider_widget.dart';

import 'change_notifier_provider_widget.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SimpleProviderWidget(),
            const ChangeNotifyProviderWidget(),
            const FutureProviderWidget(),
            StreamProviderWidget()
            // HoldValueExample()
            // SelectorExample()
            // ProxyProviderExample()
          ],
        ),
      ),
    ),
  ));
}
