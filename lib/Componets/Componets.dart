import 'package:flutter/material.dart';
void navigateTo(context, {required widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
