import 'package:flutter/material.dart';
import 'package:ontimedining/screens/HomePage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Map<String, WidgetBuilder> routes = {
      '/home': (BuildContext context) => HomePage(),
      '/menu': (BuildContext context) => Menu(),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ontimmedining',
      initialRoute: '/home',
      routes: routes,
    );
  }
}