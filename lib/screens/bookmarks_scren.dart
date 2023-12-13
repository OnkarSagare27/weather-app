import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/location_model.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/widgets/list_element.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<BookmarksScreen> {
  @override
  void dispose() {
    super.dispose();
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          weatherProviderModel.selectedLocationWeatherModel =
                              null;
                          Navigator.popUntil(
                              context, (Route route) => route.isFirst);
                        },
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Bookmarks',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
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
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: weatherProviderModel.bookmarkedLocations != null &&
                            weatherProviderModel.bookmarkedLocations!.isNotEmpty
                        ? ListView.builder(
                            itemCount: weatherProviderModel
                                .bookmarkedLocations!.length,
                            itemBuilder: (context, ind) => ListElement(
                              locationModel: LocationModel(
                                name: weatherProviderModel
                                    .bookmarkedLocations![ind]['name'],
                                state: weatherProviderModel
                                    .bookmarkedLocations![ind]['state'],
                                country: weatherProviderModel
                                    .bookmarkedLocations![ind]['country'],
                                lat: weatherProviderModel
                                    .bookmarkedLocations![ind]['lat'],
                                lon: weatherProviderModel
                                    .bookmarkedLocations![ind]['lon'],
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 20.h,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bookmark,
                                  color: Colors.grey[300],
                                  size: 50.sp,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  'Bookmarks is empty',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  'You can bookmark cities to access them from here quickly.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
