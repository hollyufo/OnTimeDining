import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';



class FoodMenu extends StatefulWidget {
  const FoodMenu({Key? key}) : super(key: key);

  @override
  _FoodMenuState createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  List<dynamic> menuItems = [];

  @override
  void initState() {
    super.initState();
    getMenuItems();
  }

  Future<void> getMenuItems() async {
    var url = Uri.parse('http://localhost:8081/api/v1/controller/getallmenu');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    setState(() {
      menuItems = jsonResponse;
    });
  }

  Future<void> addToCart(int id) async {
    // adding the id to the url as a query parameter
    var url = Uri.parse('http://localhost:8081/api/v1/controller/addtocart/$id');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item added to cart!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: menuItems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Image.network(
                menuItems[index]['image'],
                height: 100,
              ),
              SizedBox(height: 10),
              Text(
                menuItems[index]['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                menuItems[index]['description'],
              ),
              SizedBox(height: 10),
              Text(
                '\$${menuItems[index]['price']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  addToCart(menuItems[index]['id']);
                },
                child: Text('Add to Cart'),
              ),
            ],
          ),
        );
      },
    );
  }
}

