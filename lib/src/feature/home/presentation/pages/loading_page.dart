import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_pad/src/feature/home/presentation/pages/home.dart';

import '../../../../common/routes/app_route_name.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        context.go(AppRouteName.homePage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FloatingImage(),
      ),
    );
  }
}