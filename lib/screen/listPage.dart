// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/menu.dart';
import 'package:http/http.dart' as http;

class ListPage extends StatefulWidget {
  const ListPage({super.key});
  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future<List<Menu>>? menuItems;

  Future<List<Menu>> readMenu() async {
    String param = 'read';
    Map<String, dynamic> data = {'param': param};
    final jsonData = jsonEncode(data);

    try {
      String uri = 'http://localhost:8000/t_menu.php';
      final response = await http.post(
        Uri.parse(uri),
        headers: <String, String>{},
        body: jsonData,
      );

      // Handle the response (check status code, etc.)
      if (response.statusCode == 200) {
        print('Success to read data' + response.body);
        List<Menu> menuItems = (json.decode(response.body) as List)
            .map((data) => Menu.fromJson(data))
            .toList();
        return menuItems;
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to read data');
      }
    } catch (e) {
      throw Exception('Error fetching menu items: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    readMenu();
    menuItems = readMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('list data'),
      ),
      body: FutureBuilder<List<Menu>>(
          future: menuItems,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final menuItems = snapshot.data!; // Safe access after checking data

            return ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final product = menuItems[index]; // Get the current product
                return ListTile(
                  // Leading icon (optional)
                  leading: Icon(Icons.shopping_cart),

                  // Title for the product name
                  title: Text(product.name),

                  // Subtitle for the price (formatted as currency)
                  subtitle: Text(
                    '\Rp${product.price.toStringAsFixed(2)}', // Format price with 2 decimal places
                  ),

                  // Trailing icon or widget (optional)
                  trailing: Icon(Icons.chevron_right),
                );
              },
            );
          }),
    );
  }
}
