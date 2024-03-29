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
  var _cityEntered ;

  Future _goToNextScreen(BuildContext context) async{
    Map result = await Navigator.of(context).push(
      new MaterialPageRoute(builder: (BuildContext context){
        return new ChangeCity();
      })
    );
    if(result != null && result.containsKey("city")){
      _cityEntered = result['city'].toString();
    }
  }

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
              onPressed: () {_goToNextScreen(context);}
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
            child: new Text("${_cityEntered == null ? util.defaultCity : _cityEntered}" , style : new TextStyle(color: Colors.white , fontSize: 23.0 , fontStyle: FontStyle.italic)),
          ),
          new Container(
            alignment: Alignment.center,
            child: new Image.asset('images/light_rain.png'),
          ),
          new Container(
            margin: const EdgeInsets.fromLTRB(20.0, 450.0, 0.0, 0.0),
//            child : new Text("" , style: new TextStyle(color: Colors.white , fontSize: 50.0 , fontWeight: FontWeight.w500)
//            ,),
          child: updateTempWidget(_cityEntered),
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

Widget updateTempWidget(String city){
  return new FutureBuilder(
      future: getWeather(util.apiId, city == null ? 'Spokane' : city),
      builder: (BuildContext context, AsyncSnapshot <Map> snapshot){
        if(snapshot.hasData){
          Map content = snapshot.data;
          return new Container(
            child : new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(content['main']['temp'].toString(),
                      style: new TextStyle(color: Colors.white , fontSize: 50.0 , fontWeight: FontWeight.w500)
                  ),
                  subtitle: new ListTile(
                    title: new Text(
                      "Humidity : ${content['main']['humidity'].toString()}\n"
                           "Min : ${content['main']['temp_min'].toString()}\n"
                           "Max : ${content['main']['temp_max'].toString()}\n",
                      style: extraData(),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      });
}

class ChangeCity extends StatelessWidget {
  var _cityFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text("Change City"),
        centerTitle: true,
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('images/white_snow.png',
                   width: 490.0,
                   height: 1200.0 ,
                   fit: BoxFit.fill,
            )
          ),
          new ListView(
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: "Enter City",
                  ),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                ),
              ),
              new ListTile(
                title: new FlatButton(
                    onPressed: (){
                      Navigator.pop(context, {
                        'city' : _cityFieldController.text
                      });
                    },
                    textColor: Colors.white70,
                    color: Colors.redAccent,
                    child: new Text("Get Wether")
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

TextStyle extraData(){
  return new TextStyle(
    color: Colors.white70,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );
}

