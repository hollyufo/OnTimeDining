import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestaurantWidget extends StatefulWidget {
  @override
  _RestaurantWidgetState createState() => _RestaurantWidgetState();
}

class _RestaurantWidgetState extends State<RestaurantWidget> {
  List<dynamic> restaurants = [];

  Future<void> _fetchRestaurants() async {
    try {
      final response = await http.get(Uri.parse('https://example.com/api/restaurants'));
      final jsonData = jsonDecode(response.body);
      setState(() {
        restaurants = jsonData;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (BuildContext context, int index) {
        final restaurant = restaurants[index];
        return ListTile(
          title: Text(restaurant['name']),
          subtitle: Text(restaurant['address']),
        );
      },
    );
  }
}
