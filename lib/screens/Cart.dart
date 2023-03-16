import 'package:flutter/material.dart';

import '../widget/bottomnavbar.dart';
import '../widget/cartwedget.dart';
import '../widget/restaurents.dart';
import '../widget/topnavbar.dart';
// home page class
class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CNavbar(Icons.home, Icons.search),
      ),
      body: CartWidget(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}