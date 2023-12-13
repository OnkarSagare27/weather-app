import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/widgets/snackbar.dart';
import 'package:weather/widgets/humidity.dart';
import 'package:weather/widgets/wind_speed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WeatherProvider>(context, listen: false)
        .getCurrentLocationWeather();
    Provider.of<WeatherProvider>(context, listen: false).loadBookmarks();
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
            child: weatherProviderModel.currentLocationWeatherModel == null
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
                              enableFeedback: false,
                              shape: const CircleBorder(),
                              side: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            onPressed: () {},
                            child: const SizedBox(),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, 'search');
                            },
                            child: Text(
                              weatherProviderModel.currentLocationModel!.name,
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
                              Navigator.pushNamed(context, 'info');
                            },
                            child: const Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Image.network(
                        'https://openweathermap.org/img/wn/${weatherProviderModel.currentLocationWeatherModel!.icon}@4x.png',
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
                            '${weatherProviderModel.currentLocationWeatherModel!.temperature.toInt()}°',
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
                            .currentLocationWeatherModel!.descriotion),
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
                                .currentLocationWeatherModel!.windSpeed
                                .toString(),
                          ),
                          Humidity(
                            humidity: weatherProviderModel
                                .currentLocationWeatherModel!.humidity
                                .toString(),
                          )
                        ],
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'bookmarks');
                        },
                        child: const Text(
                          'Bookmarked Locations',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
