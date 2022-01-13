import 'package:flutter/material.dart';
import 'package:cake_factory/pages/home.dart';
import 'package:cake_factory/pages/loading.dart';
import 'package:cake_factory/pages/cake_factory.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/cake_factory': (context) => MakeCake(),
    }
));

