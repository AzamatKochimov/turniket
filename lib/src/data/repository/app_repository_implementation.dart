// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:l/l.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import '../../common/server/api/api.dart';
// import '../../common/server/api/api_constants.dart';
// import '../../feature/home/view_model/home_vm.dart';
// import 'app_repository.dart';
//
// @immutable
// class AppRepositoryImpl implements AppRepository {
//   AppRepositoryImpl._internal();
//
//   static final AppRepositoryImpl _instance = AppRepositoryImpl._internal();
//
//   factory AppRepositoryImpl() => _instance;
//
//   String? name = "";
//   Future<void> initializeCamera(CameraController cameraController) async {
//     await cameraController.initialize();
//   }
//
//   Future<String?> sendDataToBackend(String qrData) async {
//     final params = <String, dynamic>{
//       'qrData': qrData,
//     };
//
//     try {
//       log("qr data here => $qrData");
//
//       String basicAuth = 'Basic ${base64Encode(utf8.encode('TurniketBitrixBasicAuth:SqvMgAhzGWwDYcHb3Z'))}';
//
//       String? response = await ApiService.get(
//         ApiConst.user,
//         params,
//         {'Authorization': basicAuth},
//       );
//
//       log("API response: $response");
//
//       Map<String, dynamic> responseObj = jsonDecode(response!);
//       name = responseObj["data"]["name"];
//       return name;
//     } catch (e) {
//       l.e('Error sending data: $e');
//     }
//   }
//
//   Future<void> handleQRScan(
//       QRViewController qrController,
//       BuildContext context,
//       CameraController cameraController,
//       ) async {
//     log("--------------------------------------handleQRScan---------------------------------------");
//     qrController.pauseCamera();
//
//     await showDialog(
//       context: context,
//       builder: (context) => _buildQRDialog(context),
//     );
//
//     // showDialog(
//     //   context: context,
//     //   builder: (context) {
//     //     return const Center(
//     //       child: CircularProgressIndicator(),
//     //     );
//     //   },
//     // );
//
//     qrController.resumeCamera();
//
//     if (cameraController.value.isInitialized) {
//       try {
//         XFile picture = await cameraController.takePicture();
//         log('Picture taken: ${picture.path}');
//         // You can now send the picture to your backend or store it locally
//       } catch (e) {
//         log('Error taking picture: $e');
//       }
//     } else {
//       log('Camera is not initialized');
//     }
//   }
//
//   Widget _buildQRDialog(BuildContext context) {
//     return AlertDialog(
//       title: Text(name!, textAlign: TextAlign.center),
//       actions: [
//         SizedBox(
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               MaterialButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 color: Colors.red,
//                 textColor: Colors.white,
//                 child: const Text('Ishni tugatish'),
//               ),
//               MaterialButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 color: Colors.green,
//                 textColor: Colors.white,
//                 child: const Text('Ishni boshlash'),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Future<void> verifyUser(String qrData) async {
//     final url = ApiConst.user.replaceFirst(qrData, qrData);
//     await ApiService.get(url);
//   }
// }
