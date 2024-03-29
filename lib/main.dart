import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/screens/bookmarks_scren.dart';
import 'package:weather/screens/city_weather.dart';
import 'package:weather/screens/home_sreen.dart';
import 'package:weather/screens/info_screen.dart';
import 'package:weather/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(392.7, 872.7),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => WeatherProvider())
        ],
        child: MaterialApp(
          title: 'Weather',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.poppins().fontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          initialRoute: 'home',
          routes: {
            'home': (context) => const HomeScreen(),
            'search': (context) => const SearchScreen(),
            'cityWeather': (context) => const CityWeatherScreen(),
            'bookmarks': (context) => const BookmarksScreen(),
            'info': (context) => const InfoScreen(),
          },
        ),
      ),
    );
  }
}
