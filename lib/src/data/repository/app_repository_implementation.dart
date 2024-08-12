import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../common/server/api/api.dart';
import '../../common/server/api/api_constants.dart';
import 'app_repository.dart';

@immutable
class AppRepositoryImpl implements AppRepository {
  const AppRepositoryImpl._internal();

  static final AppRepositoryImpl _instance = AppRepositoryImpl._internal();

  factory AppRepositoryImpl() => _instance;

  Future<void> initializeCamera(CameraController cameraController) async {
    await cameraController.initialize();
  }

  Future<void> handleQRScan(
      QRViewController qrController,
      BuildContext context,
      Future<void> Function(BuildContext, String) onOptionSelected,
      ) async {
    qrController.pauseCamera();

    await showDialog(
      context: context,
      builder: (context) => _buildQRDialog(context, onOptionSelected),
    );

    qrController.resumeCamera();
  }

  Widget _buildQRDialog(BuildContext context, Future<void> Function(BuildContext, String) onOptionSelected) {

    return AlertDialog(

      title: const Text('Quyidagilardan birini tanlang', textAlign: TextAlign.center,),
      actions: [
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () async {
                  await onOptionSelected(context, "Ishni tugatish");
                  Navigator.of(context).pop();  // Close the dialog
                },
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Ishni tugatish'),
              ),
              MaterialButton(
                onPressed: () async {
                  await onOptionSelected(context, "Ishni boshlash");
                  Navigator.of(context).pop();  // Close the dialog
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

  Future<void> sendDataToBackend(String qrData) async {
    final params = <String, dynamic>{
      'qrData': qrData,
    };

    try {
      // Sending POST request and awaiting response
      log("qr data here => ${qrData}");
      final String? response = await ApiService.get(ApiConst.user, params);

      log(response!);

      // if (response?.statusCode == 200) {
      //   final responseData = jsonDecode(response?.body);
      //   l.i('Data sent successfully: $responseData');
      // } else {
      //   l.e('Failed to send data: ${response?.statusCode}');
      //   l.e('Error message: ${response?.body}');
      // }
    } catch (e) {
      // If there is an error during the request, handle it
      l.e('Error sending data: $e');
    }

    await ApiService.post(ApiConst.qrData, params, params: params);
  }

  Future<void> verifyUser(String qrData) async {
    final url = ApiConst.user.replaceFirst(qrData, qrData);
    await ApiService.get(url);
  }
}
