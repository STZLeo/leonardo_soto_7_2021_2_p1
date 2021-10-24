import 'dart:convert';
import 'dart:async';
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

    Map jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print(jsonData);
      for (var m in jsonData.keys) {
        var first = jsonData[m];
        print(first);
      }

      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Memes'),
        ),
        body: Center(
            child: ElevatedButton(
          child: Text('Get data'),
          onPressed: () {
            getMemeData();
          },
        )));
  }
}

class Memes {
  final List data;

  Memes(this.data);
}
