import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/widgets/list_element.dart';
import 'package:weather/widgets/search_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
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
                  SearchField(
                    onChanged: (input) {
                      weatherProviderModel
                          .fetchCitieseFunc(searchController.text);
                    },
                    controller: searchController,
                  ),
                  Expanded(
                    child: weatherProviderModel.suggestedCities != null &&
                            weatherProviderModel.suggestedCities!.isNotEmpty
                        ? ListView.builder(
                            itemCount:
                                weatherProviderModel.suggestedCities!.length,
                            itemBuilder: (context, ind) => ListElement(
                              locationModel:
                                  weatherProviderModel.suggestedCities![ind],
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
                                  Icons.search_rounded,
                                  color: Colors.grey[300],
                                  size: 50.sp,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  'Search a city',
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
                                  'You can bookmark cities to access them from home screen quickly.',
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
