// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/screen/inputPage.dart';
import 'package:flutter_app/screen/listPage.dart';
import 'package:flutter_app/screen/orderPage.dart';
import 'package:get/route_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Row(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
                  width: MediaQuery.of(context).size.width * 0.19,
                  height: 80,
                  color: Colors.amber,
                  child: Column(
                    children: [Text('halo')],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
                  width: MediaQuery.of(context).size.width * 0.19,
                  height: (MediaQuery.of(context).size.height - (56 + 80 + 30)),
                  color: Color.fromARGB(255, 78, 233, 122),
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.to(InputData());
                        },
                        child: Text('Input Data'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(orderPage());
                        },
                        child: Text('Order'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(ListPage());
                        },
                        child: Text('Menu List'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
              width: MediaQuery.of(context).size.width * 0.79,
              color: Colors.blue,
              child: Column(
                children: [Text('halo')],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
