import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../view_model/home_vm.dart';

class QrScanner extends ConsumerWidget {
  const QrScanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeVM = ref.watch(homeVMProvider);

    return QRView(
      key: GlobalKey(debugLabel: 'QR'),
      onQRViewCreated: (controller) {
        homeVM.setQRController(controller, context);
      },
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }
}
