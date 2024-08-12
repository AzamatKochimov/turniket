import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomeInfo extends StatelessWidget {
  const HomeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('HH:mm').format(now);
    final String formattedPeriod = DateFormat('a').format(now);
    final String formattedDate = DateFormat('EEEE, MMMM dd').format(now);
    final String capitalizedDate = formattedDate.split(', ').map((str) => str.substring(0, 1).toUpperCase() + str.substring(1)).join(', ');
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
          Text("Toshkent, O'zbekiston", style: TextStyle(fontSize: 20.sp, color: Colors.white)),
          SizedBox(height: 20.h),
          Text(formattedTime, style: TextStyle(fontSize: 68.sp, fontWeight: FontWeight.w700, color: Colors.white)),
          SizedBox(
            width: 240.w,
            child: const Divider(
              height: 2,
              thickness: 2,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5.h),
          Text(capitalizedDate, style: TextStyle(fontSize: 20.sp, color: Colors.white)),
          SizedBox(height: 10.h),
          Text(timezoneOffset, style: TextStyle(fontSize: 14.sp, color: Colors.white)),
          SizedBox(height: 15.h),
          Text("QR kodni skayner qiling", style: TextStyle(fontSize: 18.sp, color: Colors.white)),
          SizedBox(height: 36.h),
          Text("Shtrix-kod to'liq ko'rinishi shart", textAlign: TextAlign.center, style: TextStyle(fontSize: 18.sp, color: Colors.white)),
        ],
      ),
    );
  }
}
