import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:time_pad/generated/assets.dart';

class HomeInfo extends StatefulWidget {
  const HomeInfo({super.key});

  @override
  _HomeInfoState createState() => _HomeInfoState();
}

class _HomeInfoState extends State<HomeInfo> {
  late Timer _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String formattedTime = DateFormat('HH:mm').format(_now);
    final String formattedDate = DateFormat('EEEE, MMMM dd').format(_now);
    final String capitalizedDate = formattedDate
        .split(', ')
        .map((str) => str.substring(0, 1).toUpperCase() + str.substring(1))
        .join(', ');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(Assets.imagesSvgImage1, height: 50.h),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "PDP Junior",
                    style: TextStyle(fontSize: 24.sp, color: Colors.white),
                  ),
                  Text(
                    "Toshkent, O'zbekiston",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: 64.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 240.w,
            child: const Divider(
              color: Colors.white,
              thickness: 2,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            capitalizedDate,
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
