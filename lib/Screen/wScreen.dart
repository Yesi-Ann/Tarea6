import 'package:flutter/material.dart';
import 'WeatherServices.dart';
import 'WeatherModel.dart';

class WScreen extends StatefulWidget {
  const WScreen({super.key});

  @override
  _WScreenState createState() => _WScreenState();
}

class _WScreenState extends State<WScreen> {
  late Future<WeatherModel?> _weatherData;

  @override
  void initState() {
    super.initState();
    // Latitud y longitud de República Dominicana
    _weatherData = WeatherServices().fetchWeather(18.735693, -70.162651);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: FutureBuilder<WeatherModel?>(
        future: _weatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No weather data available.'));
          } else {
            final weather = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    weather.name,
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${weather.temperature.toStringAsFixed(1)}°C',
                    style: TextStyle(
                      fontSize: 48, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Humidity: ${weather.humidity}%',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Wind Speed: ${weather.windSpeed} m/s',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Pressure: ${weather.pressure} hPa',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Max Temp: ${weather.maxTemperature.toStringAsFixed(1)}°C',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Min Temp: ${weather.minTemperature.toStringAsFixed(1)}°C',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 30), // Espacio antes de la imagen
                  Image.asset(
                    'assets/weather.png', // Imagen alusiva al clima desde assets
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
