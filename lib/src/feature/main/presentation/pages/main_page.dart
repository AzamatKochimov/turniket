import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../view_model/main_vm.dart";

class MainPage extends ConsumerWidget {
  const MainPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(mainVM);
    final MainVM con = ref.read(mainVM);
    return Scaffold(
      body: child,
    );
  }
}
