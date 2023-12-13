import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Navigator.popUntil(
                            context, (Route route) => route.isFirst);
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Info',
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.w),
                  child: Text(
                    'Contact developer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/linked_in.png',
                    height: 40.h,
                    width: 40.h,
                  ),
                  title: const Text(
                    'Onkar Sagare',
                    maxLines: 1,
                  ),
                  titleTextStyle: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                  subtitle: const Text('Linked In'),
                  subtitleTextStyle: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[300],
                    fontSize: 12.sp,
                  ),
                  onTap: () async {
                    final Uri url = Uri.parse(
                        'https://www.linkedin.com/in/onkar-sagare-9a68aa251/');
                    await launchUrl(url,
                        mode: LaunchMode.externalNonBrowserApplication);
                  },
                  trailing: const Icon(
                    Icons.open_in_new_sharp,
                    color: Colors.white,
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
