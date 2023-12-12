class WeatherModel {
  final String main;
  final String descriotion;
  final double temperature;
  final double windSpeed;

  WeatherModel({
    required this.main,
    required this.descriotion,
    required this.temperature,
    required this.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      main: json["weather"][0]["main"],
      descriotion: json["weather"][0]["description"],
      temperature: json["main"]["temp"] - 272.15,
      windSpeed: json["wind"]["speed"] * 3.6,
    );
  }
}
