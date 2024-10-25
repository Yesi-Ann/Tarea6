import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:t5/Screen/WeatherModel.dart';

class WeatherServices {

  Future<WeatherModel?> fetchWeather(double latitude, double longitude) async {
    final response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=18.735693&lon=-69.89232&appid=0db661e081183010bea61149a6c55cec"));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      print('Error: ${response.statusCode}');
      return null; // Manejar el error de manera adecuada
    }
  }
}

