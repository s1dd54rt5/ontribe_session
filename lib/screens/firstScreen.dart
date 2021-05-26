import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ontribe_demo/utils/constants.dart';
import 'package:ontribe_demo/utils/size.dart';
import 'package:http/http.dart' as http;

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  Future<void> fetchData(String name) async {
    var url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$name/");
    var response = await http.get(url);
    Map res = jsonDecode(response.body);
    setState(() {
      imageUrl = res["sprites"]["front_default"];
    });
    print(res["sprites"]["front_default"]);
  }

  String imageUrl;

  TextEditingController pokeName = TextEditingController();

  bool buttonPressed = false;
  @override
  Widget build(BuildContext context) {
    SizeHelper s = new SizeHelper(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: buttonPressed ? Colors.blue : Colors.red,
            ),
            height: s.hHelper(25),
            width: s.wHelper(100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: s.wHelper(40),
                  child: ClipRRect(
                    child: imageUrl == null
                        ? Image.asset(dogPicture)
                        : Image.network(imageUrl),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: s.hHelper(10),
          ),
          TextField(
            controller: pokeName,
          ),
          SizedBox(
            height: s.hHelper(10),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              horizontal: s.wHelper(10),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.blue,
            ),
            height: s.hHelper(15),
            width: s.wHelper(100),
            child: TextButton(
              onPressed: () async {
                await fetchData(pokeName.text);
                setState(() {
                  buttonPressed = true;
                });
              },
              child: Text(
                buttonPressed ? "Button pressed!" : "Press me!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
