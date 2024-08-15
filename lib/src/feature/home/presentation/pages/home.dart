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
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (homeVM.error != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            homeVM.error!,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const HomeInfo(),
                Expanded(child: QrScanner()),
              ],
            ),
            if (homeVM.isPosting)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
