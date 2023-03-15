import 'package:flutter/material.dart';

import '../widget/bottomnavbar.dart';
import '../widget/menu.dart';
import '../widget/restaurents.dart';
import '../widget/topnavbar.dart';
// hom/e page class
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