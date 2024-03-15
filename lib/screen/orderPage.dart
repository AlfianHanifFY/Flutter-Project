import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/models/m_order.dart';

// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter_app/models/menu.dart';
import 'package:http/http.dart' as http;

class orderPage extends StatefulWidget {
  @override
  _orderPage createState() => _orderPage();
}

class _orderPage extends State<orderPage> {
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

  Order currentOrder = Order([]);

  void addToOrder(item) {
    setState(() {
      currentOrder.order.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cafe Order'),
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

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final product =
                          menuItems[index]; // Get the current product
                      return ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text(product.name),
                        subtitle: Text(
                          '\Rp${product.price.toStringAsFixed(2)}', // Format price with 2 decimal places
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            addToOrder(product);
                            print(currentOrder.order);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order Total:'),
                      Text(
                          'Rp${currentOrder.getTotalPrice().toStringAsFixed(2)}'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement order submission logic (e.g., display confirmation dialog, send order to server)
                    print('Order submitted: ${currentOrder.order}');
                  },
                  child: Text('Submit Order'),
                ),
              ],
            );
          }),
    );
  }
}
