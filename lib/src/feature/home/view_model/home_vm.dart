import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l/l.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../data/repository/app_repository_implementation.dart';

final homeVMProvider = ChangeNotifierProvider.autoDispose<HomeVM>((ref) => HomeVM(ref));

class HomeVM extends ChangeNotifier {
  final AutoDisposeChangeNotifierProviderRef<HomeVM> ref;
  final AppRepositoryImpl _repository = AppRepositoryImpl();

  bool _isLoading = true;
  String? _error;
  QRViewController? _qrController;
  CameraController? _cameraController;
  final scannedDataProvider = StateProvider<String?>((ref) => null);
  final name = null;

  HomeVM(this.ref) {
    _loadData();
  }

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> _loadData() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      _isLoading = false;
    } catch (e) {
      _error = "Failed to load data";
    } finally {
      notifyListeners();
    }
  }

  void setQRController(QRViewController controller, BuildContext context) {
    _qrController = controller;

    // Use the front camera by default for QR scanning
    _qrController?.flipCamera();

    _qrController?.scannedDataStream.listen((scanData) async {
      ref.read(scannedDataProvider.notifier).state = scanData.code;
      await _repository.handleQRScan(_qrController!, context, (context, option) => _onOptionSelected(scanData.code!));
    });
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _repository.initializeCamera(_cameraController!);
  }

  Future<void> _onOptionSelected(String qrData) async {
    await _repository.sendDataToBackend(qrData);
    _qrController?.resumeCamera();
  }

  Future<void> getUserName()async{

  }

  @override
  void dispose() {
    _qrController?.dispose();
    _cameraController?.dispose();
    super.dispose();
  }
}
