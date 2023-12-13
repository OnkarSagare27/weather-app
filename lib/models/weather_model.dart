class WeatherModel {
  final String main;
  final String descriotion;
  final String icon;
  final double temperature;
  final double windSpeed;
  final int humidity;

  WeatherModel({
    required this.main,
    required this.descriotion,
    required this.temperature,
    required this.windSpeed,
    required this.icon,
    required this.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      main: json["weather"][0]["main"],
      descriotion: json["weather"][0]["description"],
      icon: json["weather"][0]["icon"],
      temperature: json["main"]["temp"] - 272.15,
      windSpeed: json["wind"]["speed"],
      humidity: json["main"]["humidity"],
    );
  }
}
