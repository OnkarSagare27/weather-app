class LocationModel {
  final String name;
  final String? state;
  final String? country;
  final double lat;
  final double lon;

  LocationModel({
    required this.name,
    required this.state,
    required this.country,
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "state": state,
      "country": country,
      "lat": lat,
      "lon": lon
    };
  }
}
