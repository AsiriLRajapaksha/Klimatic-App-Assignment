import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../utility/utils.dart' as util;

Future<Map> getWeather(String apiId , String city) async{
  String apiUrl = "https://samples.openweathermap.org/data/2.5/weather?q=$city&appid=''${util.apiId}&utils=imperial";

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}