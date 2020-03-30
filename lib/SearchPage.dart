import 'package:flutter/material.dart';
import 'package:way_there/HomePage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _cityName;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Way-There"),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
                0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: [
              const Color(0xFFFFFFEE),
              const Color(0xFF999999)
            ], // whitish to gray
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("image/logo.png"),
                height: 200,
                width: 200,
              ),
              Container(
                padding: EdgeInsets.all(50.0),
                child: Form(
                  key: _key,
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter a city name",
                      filled: true,
                      fillColor: Colors.grey[600],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    onSaved: (val) => _cityName = val,
                    validator: (val) =>
                        val.isEmpty ? "Please Enter A City" : null,
                  ),
                ),
              ),
              RaisedButton(
                color: Colors.grey[300],
                elevation: 10.0,
                child: Text("Search"),
                onPressed: search,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future search() async {
    //FocusScope.of(context).unfocus();
    if (_key.currentState.validate()) {
      _key.currentState.save();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    cityName: _cityName,
                  )));
    } else {}
  }
}
