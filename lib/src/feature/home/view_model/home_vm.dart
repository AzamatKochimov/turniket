import 'dart:convert';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:time_pad/src/common/routes/app_route_name.dart';

import '../../../common/server/api/api.dart';
import '../../../common/server/api/api_constants.dart';

final homeVMProvider = ChangeNotifierProvider.autoDispose<HomeVM>((ref) => HomeVM(ref));

class HomeVM extends ChangeNotifier {
  final AutoDisposeChangeNotifierProviderRef<HomeVM> ref;

  bool _isLoading = true;
  bool _isPosting = false;
  String? _photoId;
  String? _qrData;
  String? _pendingStatus;  // New field to store pending status
  String? _error;
  QRViewController? _qrController;
  CameraController? _cameraController;
  bool _isDialogShowing = false;
  String? name;

  HomeVM(this.ref) {
    _loadData();
  }

  bool get isLoading => _isLoading;
  bool get isPosting => _isPosting;
  String? get error => _error;
  String? get photoId => _photoId;
  String? get qrData => _qrData;

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

  void updatePhotoId(String id) {
    _photoId = id;
    notifyListeners();

    if (_pendingStatus != null) {
      postData(_pendingStatus!);
      _pendingStatus = null;
    }
  }

  void updateQRData(String qr) {
    _qrData = qr;
    notifyListeners();
  }

  Future<String?> getUserName(String qrData) async {
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

  void setPendingStatus(String status) {
    log("==================== setPendingStatus: $status =======================");
    _pendingStatus = status;

    if (_photoId != null) {
      log("==================== PhotoID is: $_photoId =======================");
      postData(status);
      _pendingStatus = null;
    }
  }

  Future<void> postData(String status) async {
    log("============================== PostData =================================");
    if (_photoId == null) {
      log("Error: Photo ID is null");
      return;
    }

    if (_qrData == null) {
      log("Error: QR Data is null");
      return;
    }

    _isPosting = true;
    notifyListeners();

    final dateTime = DateTime.now().millisecondsSinceEpoch;

    final data = {
      "qrData": _qrData,
      "dateTime": dateTime,
      "status": status,
      "photoId": _photoId,
    };

    try {
      String basicAuth = 'Basic ${base64Encode(utf8.encode('TurniketBitrixBasicAuth:SqvMgAhzGWwDYcHb3Z'))}';

      final response = await http.post(
        Uri.parse('https://api.pdp.uz/api/turniket/v1/bitrix/inout/event'),
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        log("Data posted successfully: ${response.body}");
      } else {
        log("Failed to post data: ${response.statusCode}");
      }
    } catch (e) {
      log('Error posting data: $e');
    } finally {
      _isPosting = false;
      notifyListeners();
    }
  }

  Future<void> handleQRScan(QRViewController qrController, BuildContext context) async {
    log("-----------handleQRScan-----------");
    qrController.pauseCamera();

    await showDialog(
      context: context,
      builder: (context) => _buildQRDialog(context),
    );

    _qrController!.resumeCamera();
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
                  setPendingStatus("EXIT");
                  log("==================== EXIT =======================");
                  context.go(AppRouteName.confirmPage);
                },
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('Ishni tugatish'),
              ),
              MaterialButton(
                onPressed: () {
                  setPendingStatus("ENTER");
                  log("==================== ENTER =======================");
                  context.go(AppRouteName.confirmPage);
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

          // Update QR data
          updateQRData(scanData.code!);

          await getUserName(scanData.code!);
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
