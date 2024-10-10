import 'dart:convert';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:time_pad/src/common/local/app_storage.dart';
import 'package:time_pad/src/common/routes/app_route_name.dart';

import '../../../common/server/api/api.dart';
import '../../../common/server/api/api_constants.dart';

final homeVMProvider = ChangeNotifierProvider.autoDispose<HomeVM>((ref) => HomeVM(ref));

class HomeVM extends ChangeNotifier {
  final AutoDisposeChangeNotifierProviderRef<HomeVM> ref;

  bool _isLoading = true;
  bool _isPosting = false;
  String? _photoId;
  // String? pendingStatus;
  String? _error;
  QRViewController? _qrController;
  CameraController? _cameraController;
  bool _isDialogShowing = false;
  String? name;
  bool _isDialogDismissed = false;

  HomeVM(this.ref) {
    _loadData();
  }

  bool get isLoading => _isLoading;
  bool get isPosting => _isPosting;
  String? get error => _error;
  String? get photoId => _photoId;
  bool? get isDialogDismissed => _isDialogDismissed;

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

  Future<void> updatePhotoId(String id)async {
    log("========================================updatePhotoId");
    log("here i am ${await AppStorage.$read(key: StorageKey.pendingStatus)}");
    _photoId = id;
    notifyListeners();
  }

  Future<void> updateQRData(String qr) async {
    await AppStorage.$write(key: StorageKey.qrData, value: qr);
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

  Future<void> setPendingStatus(String status) async{
    log("==================== setPendingStatus: $status =======================");
    // pendingStatus = status;
    await AppStorage.$write(key: StorageKey.pendingStatus, value: status);

    if (_photoId != null) {
      log("==================== PhotoID is: $_photoId =======================");
      await postData(status);
      await AppStorage.$write(key: StorageKey.pendingStatus, value: null);
    } else {
      log("==================== PhotoID is: $_photoId =======================");
    }
  }

  Future<void> postData(String status) async {
    log("============================== PostData =================================");
    if (_photoId == null) {
      log("Error: Photo ID is null");
      return;
    }
    log("is error here0?");
    var postQrdata = await AppStorage.$read(key: StorageKey.qrData);
    log("is error here1? $postQrdata");
    if (postQrdata == null) {
      log("Error: QR Data is null");
      return;
    }

    log("is error here2?");
    _isPosting = true;
    log("is error here3?");
    // notifyListeners();
    final dateTime = DateTime.now().millisecondsSinceEpoch;

    log("So erro is here:");
    log("Date timee : $dateTime");
    log("ye i guess");

    final data = {
      "qrData": postQrdata,
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
        log("Data posted successfully: ${response.body} a321");
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
    isDialogDismissed == true;
    _qrController!.resumeCamera();

    await showDialog(
      barrierDismissible: true,
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
              SizedBox(
                width: MediaQuery.sizeOf(context).width*0.6,
                child: MaterialButton(
                  onPressed: () async {
                    // _isDialogDismissed = false;
                    await setPendingStatus("ENTER");
                    log("==================== ENTER =======================");
                    if (await AppStorage.$read(key: StorageKey.pendingStatus) != null) {
                      context.go(AppRouteName.confirmPage);
                    }
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  child: const Text('Ishni boshlash'),
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width*0.6,
                child: MaterialButton(
                  onPressed: () async {
                    // _isDialogDismissed = false;
                    await setPendingStatus("EXIT");
                    log("==================== EXIT =======================");
                    if (await AppStorage.$read(key: StorageKey.pendingStatus) != null) {
                      context.go(AppRouteName.confirmPage);
                    }
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: const Text('Ishni tugatish'),
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width*0.6,
                child: MaterialButton(
                  onPressed: () async {
                    context.go(AppRouteName.loading);
                  },
                  color: Colors.amber,
                  textColor: Colors.white,
                  child: const Text("Bekor qilish"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void setQRController(QRViewController controller, BuildContext context) {
    controller.flipCamera();
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
