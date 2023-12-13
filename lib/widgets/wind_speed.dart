import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/models/const.dart';

class WindSpeed extends StatelessWidget {
  final String windSpeed;
  const WindSpeed({super.key, required this.windSpeed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 80.h),
      child: Container(
        height: 180.h,
        width: 130.w,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.white,
            width: 1.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Image.asset(
                Assets.windSpeed,
                height: 40.h,
                width: 40.w,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Wind Speed',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                windSpeed,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'm/s',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
