import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class FoodMenu {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;

  FoodMenu({required this.id, required this.name, required this.image, required this.description, required this.price});

  factory FoodMenu.fromJson(Map<String, dynamic> json) {
    return FoodMenu(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
    );
  }
}

class FoodMenuList extends StatefulWidget {
  @override
  _FoodMenuListState createState() => _FoodMenuListState();
}

class _FoodMenuListState extends State<FoodMenuList> {
  List<FoodMenu> _foodMenuList = [];

  @override
  void initState() {
    super.initState();
    _getFoodMenus();
  }

  Future<void> _getFoodMenus() async {
    var response = await http.get(Uri.parse('http://localhost:8080/food-menu'));
    if (response.statusCode == 200) {
      setState(() {
        Iterable list = json.decode(response.body);
        _foodMenuList = list.map((model) => FoodMenu.fromJson(model)).toList();
      });
    } else {
      throw Exception('Failed to load food menus');
    }
  }

  Future<void> _addToCart(int id) async {
    var response = await http.post(Uri.parse('http://localhost:8082/api/v1/cart/add'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': id}));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Item added to cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Failed to add item to cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _foodMenuList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(_foodMenuList[index].image),
          title: Text(_foodMenuList[index].name),
          subtitle: Text(_foodMenuList[index].description),
          trailing: ElevatedButton(
            onPressed: () {
              _addToCart(_foodMenuList[index].id);
            },
            child: Text('Add to cart'),
          ),
        );
      },
    );
  }
}
