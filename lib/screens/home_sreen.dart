import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/conts.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/utils/utils.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProviderModel, child) => Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
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
                child: weatherProviderModel.weatherModel == null
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 80.w),
                        child: const Center(
                          child: LinearProgressIndicator(
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
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              weatherProviderModel.currentLocationModel!.name,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Image.asset(
                            Assets.iconImage[weatherProviderModel
                                .weatherModel!.main
                                .toLowerCase()]!,
                            width: 80.w,
                            height: 80.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 15.w,
                              ),
                              Text(
                                '${weatherProviderModel.weatherModel!.temperature.toInt()}°',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 80.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            capitalize(
                                weatherProviderModel.weatherModel!.descriotion),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
