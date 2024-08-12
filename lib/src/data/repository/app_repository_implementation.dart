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
    log("sendDataToBackend");
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
      BuildContext context
      ) async {
    log("handleQRScan");
    qrController.pauseCamera();

    await showDialog(
      context: context,
      builder: (context) => _buildQRDialog(context),
    );


    qrController.resumeCamera();
  }

  Future<void> captureAndUploadPhoto(CameraController cameraController) async {
    try {
      // Capture the photo
      final XFile photo = await cameraController.takePicture();

      // Convert the image to Base64
      final bytes = await photo.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Upload the photo to the API
      // String basicAuth = 'Basic ${base64Encode(utf8.encode('TurniketBitrixBasicAuth:SqvMgAhzGWwDYcHb3Z'))}';
      // var response = await http.post(
      //   Uri.parse('${ApiConst.baseUrl}/api/attachment/v1/attachment/upload'),
      //   headers: {'Authorization': basicAuth},
      //   body: {'image_base64': base64Image},
      // );

      var response = await ApiService.post(ApiConst.photoId, {'image_base64': base64Image}, params: {});
      Map<String, dynamic> responseObj = jsonDecode(response!);

      if (responseObj['success'] == true) {
        log('Photo uploaded successfully!');
      } else {
        log('Failed to upload photo: ${responseObj['errors']['errorMsg']}');
      }
    } catch (e) {
      log('Error capturing or uploading photo: $e');
    }
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
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // captureAndUploadPhoto(cameraController);
                },
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Ishni tugatish'),
              ),
              MaterialButton(
                onPressed: () {
                  // captureAndUploadPhoto(cameraController);
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