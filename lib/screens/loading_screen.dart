import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/location.dart';

const apiKey = "72d8a7df3d2cfa42e98082f3e3d5b5dd";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    print("latitude $latitude");
    print("longitude $longitude");
  }

  Future<void> getData() async {
    http.Response response = await http.get(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey");
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      double temperature = decodedData["main"]["temp"];
      int condition = decodedData["weather"][0]["id"];
      String city = decodedData["sys"]["country"];

      print(temperature);
      print(condition);
      print(city);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
