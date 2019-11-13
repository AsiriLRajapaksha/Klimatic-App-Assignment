import 'package:flutter/material.dart';

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
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
              onPressed: ()=>{debugPrint("hey")}
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
