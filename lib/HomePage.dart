import 'package:flutter/material.dart';

import 'package:way_there/Weather.dart';

class HomePage extends StatefulWidget {
  String cityName;
  HomePage({Key key, this.cityName}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Way-There"),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Weather(widget.cityName),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.search),
      //   backgroundColor: Colors.grey[900],
      //   onPressed: () {
      //     Navigator.pop(context, '/SearchPage');
      //   },
      // ),
    );
  }
}
