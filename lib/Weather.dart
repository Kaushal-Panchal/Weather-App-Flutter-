import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather extends StatefulWidget {
  String _cityName = "";
  Weather(this._cityName);
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  List weatherData;
  var windData;
  String temp, pressure, humidity, wind, maxtemp, mintemp;
  var mainDescription, description;
  var mainData;
  String iconUrl;
  var image;
  var weatherIcon;
  bool isLoading = true;
  Future getDTJ() async {
    String cityName = widget._cityName;

    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=09c6495a3d611bab4a5afaa1d0195498";
    var response = await http.get(Uri.encodeFull(url));
    var fetchedWeatherData = jsonDecode(response.body);
    print(fetchedWeatherData);
    setState(() {
      weatherData = fetchedWeatherData["weather"];
      mainData = fetchedWeatherData["main"];
      this.temp = (mainData["temp"] - 273.15).toString().substring(0, 4);
      this.maxtemp = (mainData["temp_max"] - 273.15).toString().substring(0, 4);
      this.mintemp = (mainData["temp_min"] - 273.15).toString().substring(0, 4);
      this.humidity = mainData["humidity"].toString();
      this.pressure = mainData["pressure"].toString();
      this.wind = fetchedWeatherData["wind"]["speed"].toString();
      this.description = weatherData[0]["description"];
      this.mainDescription = weatherData[0]["main"];
      this.weatherIcon = weatherData[0]["icon"];
      iconUrl = "http://openweathermap.org/img/wn/$weatherIcon@2x.png";

      image = NetworkImage(iconUrl);
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getDTJ();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
          ))
        : Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(
                    0.8, 0.0), // 10% of the width, so there are ten blinds.
                colors: [
                  const Color(0xFFFFFFEE),
                  const Color(0xFF999999)
                ], // whitish to gray
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 50.0)),
                        Text(
                          temp + "°C",
                          style: TextStyle(
                            fontSize: 70.0,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(20.0)),
                    Column(
                      children: <Widget>[
                        Image(
                          image: image,
                        ),
                        Text(
                          mainDescription,
                          style: TextStyle(fontSize: 10.0),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 150.0)),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 10.0,
                      color: Colors.grey[600],
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(bottom: 25.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text("Pressure"),
                                  Text(
                                    pressure + "Pa",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text("Humidity"),
                                  Text(humidity + "%",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text("Wind"),
                                  Text(wind + "km/h",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 45.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(maxtemp + "°C",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400)),
                              Container(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Image(
                                  image: AssetImage("image/bar.png"),
                                  height: 50.0,
                                  width: 50.0,
                                ),
                              ),
                              Text(mintemp + "°C",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 55.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget._cityName,
                                style: TextStyle(
                                  fontSize: 40.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
