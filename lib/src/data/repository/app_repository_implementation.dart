import 'dart:convert';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../common/server/api/api.dart';
import '../../common/server/api/api_constants.dart';
import 'app_repository.dart';

@immutable
class AppRepositoryImpl implements AppRepository {
  AppRepositoryImpl._internal();

  static final AppRepositoryImpl _instance = AppRepositoryImpl._internal();

  factory AppRepositoryImpl() => _instance;

  String? name = "";

  Future<void> initializeCamera(CameraController cameraController) async {
    await cameraController.initialize();
  }

  Future<String?> sendDataToBackend(String qrData) async {
    final params = <String, dynamic>{
      'qrData': qrData,
    };

    try {
      log("qr data here => $qrData");

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
      l.e('Error sending data: $e');
    }
  }

  Future<void> handleQRScan(
      QRViewController qrController,
      BuildContext context,
      ) async {
    qrController.pauseCamera();

    await showDialog(
      context: context,
      builder: (context) => _buildQRDialog(context),
    );


    qrController.resumeCamera();
  }

  Widget _buildQRDialog(BuildContext context) {
    return AlertDialog(
      title: Text(name!, textAlign: TextAlign.center),
      actions: [
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the dialog
                },
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Ishni tugatish'),
              ),
              MaterialButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the dialog
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

  Future<void> verifyUser(String qrData) async {
    final url = ApiConst.user.replaceFirst(qrData, qrData);
    await ApiService.get(url);
  }
}
