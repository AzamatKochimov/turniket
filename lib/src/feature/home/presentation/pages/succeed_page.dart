import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_pad/src/common/routes/app_route_name.dart';

class SucceedPage extends StatelessWidget {
  const SucceedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the home page after 3 seconds
    Timer(const Duration(seconds: 3), () {
      context.go(AppRouteName.homePage);
    });

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 80),
            SizedBox(height: 20),
            Text(
              'Success!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}