import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: DataFromApi());
  }
}

class DataFromApi extends StatefulWidget {
  @override
  _DataFromApiState createState() => _DataFromApiState();
}

class _DataFromApiState extends State<DataFromApi> {
  Future getMemeData() async {
    var response =
        await http.get(Uri.parse('https://api.doge-meme.lol/v1/memes/'));
    Map data = jsonDecode(response.body);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Memes'),
        ),
        body: Center(
            child: ElevatedButton(
          child: Text('Click me'),
          onPressed: () {
            getMemeData();
          },
        )));
  }
}

class Memes {
  final String submission_url, author, created;

  Memes(this.submission_url, this.author, this.created);
}
