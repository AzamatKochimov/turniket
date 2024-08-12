import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomeInfo extends StatelessWidget {
  const HomeInfo({super.key});

  @override
  Widget build(BuildContext context) {

    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('h:mm').format(now);
    final String formattedPeriod = DateFormat('a').format(now);
    final String formattedDate = DateFormat('EEEE, MMMM dd', 'ru').format(now);
    final String timezoneOffset = now.timeZoneOffset.isNegative
        ? "-${now.timeZoneOffset.abs().inHours.toString().padLeft(2, '0')}:${(now.timeZoneOffset.abs().inMinutes % 60).toString().padLeft(2, '0')}"
        : "+${now.timeZoneOffset.inHours.toString().padLeft(2, '0')}:${(now.timeZoneOffset.inMinutes % 60).toString().padLeft(2, '0')}";


    return Container(
      margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 30.h),
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Text("PDP Junior", style: TextStyle(fontSize: 24.sp, color: Colors.white)),
          Text("Ташкент, Узбекистан", style: TextStyle(fontSize: 20.sp, color: Colors.white)),
          SizedBox(height: 20.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(formattedTime, style: TextStyle(fontSize: 68.sp, fontWeight: FontWeight.w700, color: Colors.white)),
              Text(formattedPeriod, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white)),
            ],
          ),
          SizedBox(
            width: 240.w,
            child: const Divider(
              height: 2,
              thickness: 2,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5.h),
          Text(formattedDate, style: TextStyle(fontSize: 20.sp, color: Colors.white)),
          SizedBox(height: 10.h),
          Text(timezoneOffset, style: TextStyle(fontSize: 14.sp, color: Colors.white)),
          SizedBox(height: 15.h),
          Text("Отсканируйте свой бейдж", style: TextStyle(fontSize: 18.sp, color: Colors.white)),
          SizedBox(height: 36.h),
          Text("Штрих-код должен быть виден полностью", textAlign: TextAlign.center, style: TextStyle(fontSize: 18.sp, color: Colors.white)),
        ],
      ),
    );
  }
}
