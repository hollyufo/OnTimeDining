import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widget/bottomnavbar.dart';
import '../widget/menufo.dart';
import '../widget/topnavbar.dart';

class menuPage extends StatelessWidget {
  const menuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CNavbar(Icons.home, Icons.search),
      ),
      body: FoodMenu(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}