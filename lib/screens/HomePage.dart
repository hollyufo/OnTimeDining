import 'package:flutter/material.dart';

import '../widget/bottomnavbar.dart';
import '../widget/restaurents.dart';
import '../widget/topnavbar.dart';
// home page class
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CNavbar(Icons.home, Icons.search),
      ),
      body: RestaurantWidget(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}