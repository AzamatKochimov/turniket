import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

final homeVMProvider = ChangeNotifierProvider.autoDispose<HomeVM>((ref) => HomeVM(ref));

class HomeVM extends ChangeNotifier {
  final AutoDisposeChangeNotifierProviderRef<HomeVM> ref;
  bool _isLoading = true;
  String? _error;
  QRViewController? _qrController;
  CameraController? _cameraController;

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

    // Use front camera by default for QR scanning
    _qrController?.flipCamera();

    _qrController?.scannedDataStream.listen((scanData) async {
      await _handleQRScan(scanData, context);
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

    await _cameraController?.initialize();
  }

  Future<void> _handleQRScan(Barcode scanData, BuildContext context) async {
    _qrController?.pauseCamera();

    // Show dialog
    showDialog(
      context: context,
      builder: (context) => _buildQRDialog(context, scanData.code!),
    );
  }

  Widget _buildQRDialog(BuildContext context, String qrData) {
    return AlertDialog(
      title: const Text('Выберите, что вы сделали'),
      content: const Text('Выберите вариант ниже:'),
      actions: [
        MaterialButton(
          onPressed: () => _onOptionSelected(context, qrData, "Я ушел"),
          color: Colors.red,
          textColor: Colors.white,
          child: const Text('Я ушел'),
        ),
        MaterialButton(
          onPressed: () => _onOptionSelected(context, qrData, "Я пришел"),
          color: Colors.green,
          textColor: Colors.white,
          child: const Text('Я пришел'),
        ),
      ],
    );
  }

  Future<void> _onOptionSelected(BuildContext context, String qrData, String option) async {
    final XFile? picture = await _cameraController?.takePicture();

    await _sendDataToBackend(qrData, option, picture);

    Navigator.of(context).pop();
    _qrController?.resumeCamera();
    log("Camera took a picture");
  }

  Future<void> _sendDataToBackend(String qrData, String option, XFile? picture) async {
    // Implement the logic to send data to your backend
    // Example:
    // final response = await http.post(
    //   Uri.parse('your_backend_endpoint'),
    //   body: {
    //     'qrData': qrData,
    //     'option': option,
    //     'picture': picture?.path,
    //   },
    // );
  }

  @override
  void dispose() {
    _qrController?.dispose();
    _cameraController?.dispose();
    super.dispose();
  }
}
