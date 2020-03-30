import 'package:flutter/material.dart';
import 'package:way_there/HomePage.dart';
import 'package:way_there/SearchPage.dart';
// api "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=09c6495a3d611bab4a5afaa1d0195498";
// image "http://openweathermap.org/img/wn/$weatherIcon@2x.png"

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Way-There",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: SearchPage(),
      routes: <String, WidgetBuilder>{
        "/SearchPage": (BuildContext context) => SearchPage(),
        "/HomePage": (BuildContext context) => HomePage(),
      },
    );
  }
}
