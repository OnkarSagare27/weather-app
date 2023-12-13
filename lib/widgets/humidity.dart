import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/models/const.dart';

class Humidity extends StatelessWidget {
  final String humidity;
  const Humidity({super.key, required this.humidity});

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
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: Column(
            children: [
              Image.asset(
                Assets.humidity,
                height: 40.h,
                width: 40.w,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Humidity',
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
                humidity,
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
                '%',
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
