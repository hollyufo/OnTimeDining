import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrdersWidget extends StatefulWidget {
  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  List<dynamic> _orders = [];

  Future<void> _fetchOrders() async {
    final response = await http.get(Uri.parse('http://localhost:8081/api/v1/controller/orders/all'));
    if (response.statusCode == 200) {
      setState(() {
        _orders = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _orders.map((order) {
          return Card(
            child: ExpansionTile(
              title: Text('Order #${order['id']}'),
              children: [
                ListTile(
                  title: Text('Order date: ${order['orderDate']}'),
                ),
                ListTile(
                  title: Text('Order status: ${order['orderStatus']}'),
                ),
                ListTile(
                  title: Text('Total amount: ${order['totalAmount']}'),
                ),
                Divider(),
                ...order['orderItems'].map((orderItem) {
                  return ListTile(
                    title: Text('${orderItem['menu']['name']} (${orderItem['quantity']}x)'),
                    subtitle: Text('\$${orderItem['menu']['price']} each'),
                  );
                }).toList(),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
