import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_pad/generated/assets.dart';

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
          child: Center(
            child: FloatingImage(),
          ),
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
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.5, color: Colors.white),
                        left: BorderSide.none,
                        right: BorderSide.none,
                        bottom: BorderSide.none,
                      ),
                    ),
                    child: const QrScanner(),
                  ),
                ),
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

class FloatingImage extends StatefulWidget {
  const FloatingImage({super.key});

  @override
  _FloatingImageState createState() => _FloatingImageState();
}

class _FloatingImageState extends State<FloatingImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Center(
        child: Image.asset(
          Assets.imagesPdpJuniorLogo,
          height: 100,
        ),
      ),
    );
  }
}
