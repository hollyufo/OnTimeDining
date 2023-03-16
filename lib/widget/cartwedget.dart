import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

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

  void _checkout() async {
    final cartItems = await _cartItems;
    final List<int> itemIds = cartItems.map<int>((cartItem) => cartItem['menu']['id'] as int).toList();

    final response = await http.get(Uri.parse('http://localhost:8081/api/v1/controller/orders/${itemIds.join(',')}'));
    if (response.statusCode == 200) {
      // Handle success
      Fluttertoast.showToast(
        msg: 'Checkout successful',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Refresh the list of cart items
      setState(() {
        _cartItems = _fetchCartItems();
      });
    } else {
      // Handle error
      Fluttertoast.showToast(
        msg: 'Failed to checkout',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _cartItems,
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          final cartItems = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
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
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _checkout,
                    child: Text('Checkout'),
                  ),
                ),
              ),
            ],
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
