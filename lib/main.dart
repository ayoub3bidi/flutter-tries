import 'package:flutter/material.dart';
import 'package:flutter_tries/pages/choose_location.dart';
import 'package:flutter_tries/pages/loading.dart';
import 'pages/home.dart';

void main() {
  runApp( MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Loading(),
      '/home': (context) => const Home(),
      '/location': (context) => const ChooseLocation()
    },
  ));
}