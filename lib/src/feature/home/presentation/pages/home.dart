import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../generated/assets.dart';
import '../../view_model/home_vm.dart';
import '../widgets/home_widgets.dart';
import '../widgets/qr_scanner.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeVM = ref.watch(homeVMProvider);

    if (homeVM.isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Image.asset(
            Assets.imagesPdpJuniorLogo,
            height: 130,
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
            const Column(
              children: [
                HomeInfo(),
                Expanded(child: QrScanner()),
              ],
            ),
            if (homeVM.isPosting)
              Center(
                child: Image.asset(
                  Assets.imagesPdpJuniorLogo,
                  height: 130,
                ),
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
      duration: const Duration(milliseconds: 800),
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
          height: 130,
        ),
      ),
    );
  }
}
