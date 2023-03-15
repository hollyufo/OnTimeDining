import 'package:flutter/material.dart';
// home page class
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ontimmedining'),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}