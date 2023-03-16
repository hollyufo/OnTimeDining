import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  late Future<List<Map<String, dynamic>>> _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = _fetchCartItems();
  }

  Future<List<Map<String, dynamic>>> _fetchCartItems() async {
    final response = await http.get(Uri.parse('http://localhost:8081/api/v1/controller/getallcart'));

    if (response.statusCode == 200) {
      final List<dynamic> cartItemsJson = jsonDecode(response.body);
      return cartItemsJson.map((cartItemJson) => cartItemJson as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to fetch cart items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _cartItems,
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          final cartItems = snapshot.data!;
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (BuildContext context, int index) {
              final cartItem = cartItems[index];
              final menu = cartItem['menu'];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Image.network(menu['image']),
                    title: Text(menu['name']),
                    subtitle: Text(menu['description']),
                    trailing: Text('\$${cartItem['price']}'),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
