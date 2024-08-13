import 'dart:convert';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../common/server/api/api.dart';
import '../../../common/server/api/api_constants.dart';

final homeVMProvider = ChangeNotifierProvider.autoDispose<HomeVM>((ref) => HomeVM(ref));

class HomeVM extends ChangeNotifier {
  final AutoDisposeChangeNotifierProviderRef<HomeVM> ref;

  bool _isLoading = true;
  String? _error;
  QRViewController? _qrController;
  CameraController? _cameraController;
  bool _isDialogShowing = false;
  String? name;

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

  Future<void> initializeCamera() async {
    if (_cameraController != null) {
      if (_cameraController!.value.isInitialized) {
        log('Camera is already initialized');
        return;
      } else {
        await _cameraController!.dispose(); // Dispose of the existing controller if it's not initialized properly
        _cameraController = null;
      }
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

  Future<String?> sendDataToBackend(String qrData) async {
    final params = <String, dynamic>{
      'qrData': qrData,
    };

    try {
      log("QR data: $qrData");

      String basicAuth = 'Basic ${base64Encode(utf8.encode('TurniketBitrixBasicAuth:SqvMgAhzGWwDYcHb3Z'))}';

      String? response = await ApiService.get(
        ApiConst.user,
        params,
        {'Authorization': basicAuth},
      );

      log("API response: $response");

      Map<String, dynamic> responseObj = jsonDecode(response!);
      name = responseObj["data"]["name"];
      return name;
    } catch (e) {
      log('Error sending data: $e');
    }
    return null;
  }

  Future<void> handleQRScan(QRViewController qrController, BuildContext context) async {
    log("-----------handleQRScan-----------");
    qrController.pauseCamera();

    await showDialog(
      context: context,
      builder: (context) => _buildQRDialog(context),
    );

    if (_cameraController?.value.isInitialized ?? false) {
      try {
        XFile picture = await _cameraController!.takePicture();
        log('Picture taken: ${picture.path}');
        // Handle the picture (e.g., send it to the backend or store it locally)

        await Future.delayed(const Duration(seconds: 2));
      } catch (e) {
        log('Error taking picture: $e');
      }
    } else {
      log('Camera is not initialized');
    }

    // Ensure the QR scanner is resumed properly
    if (_qrController != null) {
      _qrController!.resumeCamera();
      _cameraController!.initialize();
    }
  }

  Widget _buildQRDialog(BuildContext context) {
    return AlertDialog(
      title: Text(name ?? '', textAlign: TextAlign.center),
      actions: [
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Ishni tugatish'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Ishni boshlash'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void setQRController(QRViewController controller, BuildContext context) {
    log("setQRController");
    if (_qrController == null) {
      _qrController = controller;

      _qrController?.scannedDataStream.listen((scanData) async {
        if (!_isDialogShowing) {
          _isDialogShowing = true;

          if (_cameraController == null || !_cameraController!.value.isInitialized) {
            await initializeCamera();
          }

          await sendDataToBackend(scanData.code!);
          await handleQRScan(_qrController!, context);

          _isDialogShowing = false;
        }
      });
    }
  }

  @override
  void dispose() {
    _qrController?.dispose();
    _cameraController?.dispose();
    _cameraController = null;
    _qrController = null;
    super.dispose();
  }
}