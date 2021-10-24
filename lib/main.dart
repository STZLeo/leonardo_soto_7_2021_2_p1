// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map mapResponse;
  late List listOfData;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse('https://api.doge-meme.lol/v1/memes/'));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listOfData = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Memes'),
        ),
        body: mapResponse == null
            ? Container()
            : SingleChildScrollView(
                child: Column(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            Image.network(listOfData[index]['submission_url']),
/*                             Text(
                              listOfData[index]['submission_id'].toString(),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ), */
                            Text(
                              listOfData[index]['submission_url'].toString(),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              listOfData[index]['submission_title'].toString(),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              listOfData[index]['permalink'].toString(),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              listOfData[index]['created'].toString(),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              listOfData[index]['author'].toString(),
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: listOfData == null ? 0 : listOfData.length,
                  )
                ],
              )));
  }
}
