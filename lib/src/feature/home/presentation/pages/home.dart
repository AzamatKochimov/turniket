import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_pad/src/feature/home/presentation/widgets/home_widgets.dart';
import 'package:time_pad/src/feature/home/presentation/widgets/qr_scanner.dart';

import '../../view_model/home_vm.dart';

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

    return Scaffold(
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
    );
  }
}
