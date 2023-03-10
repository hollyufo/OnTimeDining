import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Map<String, WidgetBuilder> routes = {
      '/login': (BuildContext context) => LoginPage(),
      '/home': (BuildContext context) => HomePage(),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ontimmedining',
      initialRoute: '/login',
      routes: routes,
    );
  }
}