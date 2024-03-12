import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app/screen/homePage.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'dart:async';

class InputData extends StatefulWidget {
  const InputData({super.key});

  @override
  State<InputData> createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  String result = '';

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    Map<String, dynamic> data = {
      'id': double.parse(idController.text),
      'name': nameController.text,
      'price': double.parse(priceController.text),
      'param': 'insert',
    };

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
              TextField(
                controller: idController,
                decoration: InputDecoration(
                  labelText: 'id',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
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
