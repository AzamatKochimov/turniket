import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/home_vm.dart';
import '../widgets/home_widgets.dart';
import '../widgets/qr_scanner.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeVM = ref.watch(homeVMProvider);

    if (homeVM.isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (homeVM.error != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            homeVM.error!,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/background.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeInfo(),
                    Expanded(
                      child: QrScanner(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (homeVM.isPosting) // Show loading indicator during postData
          const Positioned.fill(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
