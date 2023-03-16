import 'package:flutter/material.dart';
import 'package:ontimedining/screens/Cart.dart';
import 'package:ontimedining/screens/HomePage.dart';
import 'package:ontimedining/screens/menuPage.dart';


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
      '/menu': (BuildContext context) => menuPage(),
      '/cart': (BuildContext context) => Cart(),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ontimmedining',
      initialRoute: '/home',
      routes: routes,
    );
  }
}