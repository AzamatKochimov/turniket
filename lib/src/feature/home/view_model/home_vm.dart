import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  bool _isDialogShowing = false;

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
    log("setQRController");
    if (_qrController == null) {
      _qrController = controller;

      _qrController?.flipCamera();

      _qrController?.scannedDataStream.listen((scanData) async {
        final previousScanData = ref.read(scannedDataProvider.notifier).state;
        // Prevent re-processing the same QR code
        if (previousScanData != scanData.code) {
          ref.read(scannedDataProvider.notifier).state = scanData.code;
          await _repository.sendDataToBackend(scanData.code!);
          await _repository.handleQRScan(_qrController!, context);
        }
      });
    }
  }


  Future<void> initializeCamera() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      log('Camera is already initialized');
      return;
    }

    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      log('Camera initialized successfully');
    } catch (e) {
      log('Error initializing camera: $e');
      _cameraController = null;
    }
  }

  void setQRController(QRViewController controller, BuildContext context) {
    log("setQRController");
    if (_qrController == null) {
      _qrController = controller;

      // _qrController!.flipCamera();

      _qrController?.scannedDataStream.listen((scanData) async {
        if (!_isDialogShowing) {
          _isDialogShowing = true;

          // Ensure the camera is initialized before taking a picture
          if (_cameraController == null || !_cameraController!.value.isInitialized) {
            await initializeCamera();
          }

          // Proceed with sending data and showing the dialog
          await _repository.sendDataToBackend(scanData.code!);
          await _repository.handleQRScan(_qrController!, context, _cameraController!);

          _isDialogShowing = false;
        }
      });
    }
  }

  @override
  void dispose() {
    _qrController?.dispose();
    _cameraController?.dispose();
    super.dispose();
  }
}
