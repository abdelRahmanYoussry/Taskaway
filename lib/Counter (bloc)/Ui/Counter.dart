
import 'package:algorizainternship/Style/Colors.dart';
import 'package:flutter/material.dart';

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
