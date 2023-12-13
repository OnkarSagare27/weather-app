import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/location_model.dart';
import 'package:weather/providers/weather_provider.dart';

class ListElement extends StatelessWidget {
  final LocationModel? locationModel;

  const ListElement({super.key, required this.locationModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.location_city_rounded,
        color: Colors.white,
      ),
      title: Text(
        locationModel!.name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        locationModel!.state != null
            ? '${locationModel!.state!}, ${locationModel!.country ?? ''}'
            : locationModel!.country ?? '',
        style: TextStyle(
          color: Colors.grey[300],
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        Provider.of<WeatherProvider>(context, listen: false)
            .selectedLocationModel = locationModel;
        Navigator.pushNamed(context, 'cityWeather');
      },
    );
  }
}
