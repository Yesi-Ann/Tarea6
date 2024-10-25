class WeatherModel {
  final String name;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final double maxTemperature;
  final double minTemperature;
  final int pressure;

  WeatherModel({
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.maxTemperature,
    required this.minTemperature,
    required this.pressure,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      name: json['name'],
      temperature: json['main']['temp'] - 273.15, // Convertir de Kelvin a Celsius
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      maxTemperature: json['main']['temp_max'] - 273.15, // Convertir de Kelvin a Celsius
      minTemperature: json['main']['temp_min'] - 273.15, // Convertir de Kelvin a Celsius
      pressure: json['main']['pressure'],
    );
  }
}
