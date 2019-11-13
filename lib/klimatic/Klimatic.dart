import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../utility/utils.dart' as util;


class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {

  void showStaff() async {
    Map data = await  getWeather(util.apiId, util.defaultCity);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Klimatic"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: showStaff
              ),
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('images/umbrella.png',
            width: 500.0,
            height: 1000.0,
            fit: BoxFit.fill,),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.0, 0.0),
            child: new Text("Spokane" , style : new TextStyle(color: Colors.white , fontSize: 23.0 , fontStyle: FontStyle.italic)),
          ),
          new Container(
            alignment: Alignment.center,
            child: new Image.asset('images/light_rain.png'),
          ),
          new Container(
            margin: const EdgeInsets.fromLTRB(20.0, 450.0, 0.0, 0.0),
            child : new Text("67.5F" , style: new TextStyle(color: Colors.white , fontSize: 50.0 , fontWeight: FontWeight.w500),),
          )
        ],
      ),
    );
  }
}
Future<Map> getWeather(String apiId , String city) async{
  String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${util.apiId}&utils=imperial";
                  //'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=''${util.appId}&units=imperial';

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}

