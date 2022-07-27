
import 'package:flutter/material.dart';

import '../Style/Colors.dart';
import 'CounterWidget.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
      ),
      body: CounterWidget(),
    );
  }
}
