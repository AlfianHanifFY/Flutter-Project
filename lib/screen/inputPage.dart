import 'dart:convert';
import 'package:flutter_app/models/menu.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';

class InputData extends StatefulWidget {
  const InputData({super.key});

  @override
  State<InputData> createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String result = '';

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    String name = nameController.text;
    double price = double.parse(priceController.text);
    String param = 'insert';

    Menu newMenu = Menu(name, price);

    Map<String, dynamic> data = newMenu.toJson();
    data['param'] = param;

    String jsonData = jsonEncode(data);

    try {
      String uri = 'http://localhost:8000/t_menu.php';
      final response = await http.post(
        Uri.parse(uri),
        headers: <String, String>{},
        body: jsonData,
      );
      print(response.statusCode);
      // Handle the response (check status code, etc.)
      if (response.statusCode == 200) {
        print('Success to post data');
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to post data');
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
        title: Text('input data'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(''),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.food_bank),
                ),
              ),
              Text(""),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                ),
              ),
              Text(""),
              ElevatedButton(
                onPressed: () {
                  submitForm();
                },
                child: Text('SAVE'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 216, 234, 249)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
