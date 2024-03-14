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
  String result = '';
  List<Menu> menuItems = [];

  Future<void> readMenu() async {
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
        List<Menu> menus = (json.decode(response.body) as List)
            .map((data) => Menu.fromJson(data))
            .toList();
        print(menus);
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to read data');
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('list data'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              readMenu();
            },
            child: Text('READ'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 216, 234, 249)),
            ),
          ),
        ],
      ),
    );
  }
}
