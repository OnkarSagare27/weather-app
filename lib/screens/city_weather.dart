import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/widgets/humidity.dart';
import 'package:weather/widgets/snackbar.dart';
import 'package:weather/widgets/wind_speed.dart';

class CityWeatherScreen extends StatefulWidget {
  const CityWeatherScreen({super.key});

  @override
  State<CityWeatherScreen> createState() => _CityWeatherScreenState();
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false)
        .getSelectedLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProviderModel, child) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff95A4FF),
                Color(0xff53BDF7),
              ],
            ),
          ),
          child: SafeArea(
            child: weatherProviderModel.selectedLocationWeatherModel == null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.w),
                    child: const Center(
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const CircleBorder(),
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              weatherProviderModel
                                  .selectedLocationWeatherModel = null;
                              Navigator.popUntil(
                                  context, (Route route) => route.isFirst);
                            },
                            child: const Icon(
                              Icons.home_rounded,
                              color: Colors.white,
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              weatherProviderModel
                                  .selectedLocationWeatherModel = null;
                              Navigator.pushNamedAndRemoveUntil(context,
                                  'search', (Route route) => route.isFirst);
                            },
                            child: Text(
                              weatherProviderModel.selectedLocationModel!.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: const CircleBorder(),
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              weatherProviderModel.bookmarkedLocations!
                                      .any(
                                          (element) =>
                                              element['name'] ==
                                                  weatherProviderModel
                                                      .selectedLocationModel!
                                                      .name &&
                                              element['state'] ==
                                                  weatherProviderModel
                                                      .selectedLocationModel!
                                                      .state &&
                                              element['country'] ==
                                                  weatherProviderModel
                                                      .selectedLocationModel!
                                                      .country)
                                  ? {
                                      weatherProviderModel.removeFromBookmarks(
                                          weatherProviderModel
                                              .selectedLocationModel!
                                              .toMap()),
                                      showSnackBar(context,
                                          '${weatherProviderModel.selectedLocationModel!.name} Removed from bookmarks')
                                    }
                                  : {
                                      weatherProviderModel.addToBookmarks(
                                          weatherProviderModel
                                              .selectedLocationModel!
                                              .toMap()),
                                      showSnackBar(context,
                                          '${weatherProviderModel.selectedLocationModel!.name} Added to bookmarks')
                                    };
                            },
                            child: weatherProviderModel.bookmarkedLocations!
                                    .any((element) =>
                                        element['name'] ==
                                            weatherProviderModel
                                                .selectedLocationModel!.name &&
                                        element['state'] ==
                                            weatherProviderModel
                                                .selectedLocationModel!.state &&
                                        element['country'] ==
                                            weatherProviderModel
                                                .selectedLocationModel!.country)
                                ? const Icon(
                                    Icons.bookmark_added_rounded,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.bookmark_add_outlined,
                                    color: Colors.white,
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Image.network(
                        'https://openweathermap.org/img/wn/${weatherProviderModel.selectedLocationWeatherModel!.icon}@4x.png',
                        width: 100.w,
                        height: 100.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            '${weatherProviderModel.selectedLocationWeatherModel!.temperature.toInt()}°',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 80.sp,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        capitalize(weatherProviderModel
                            .selectedLocationWeatherModel!.descriotion),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WindSpeed(
                            windSpeed: weatherProviderModel
                                .selectedLocationWeatherModel!.windSpeed
                                .toString(),
                          ),
                          Humidity(
                            humidity: weatherProviderModel
                                .selectedLocationWeatherModel!.humidity
                                .toString(),
                          )
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
