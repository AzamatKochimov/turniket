import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:time_pad/src/common/routes/app_route_name.dart';

import '../../home/view_model/home_vm.dart';

class Confirmation extends ConsumerStatefulWidget {
  const Confirmation({super.key});

  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends ConsumerState<Confirmation> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int _countdown = 3; // Countdown starts from 3
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeController();
  }

  Future<void> _initializeController() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
    setState(() {});

    if (mounted) {
      _startCountdown();
    }
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        if (_countdown > 3) {
          _countdown--;
        } else {
          _takePicture();
          timer.cancel();
        }
      });
    });
  }

  Future<void> _uploadPhoto(XFile image) async {
    log("======================_uploadPhoto=======================");
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.pdp.uz/api/attachment/v1/attachment/upload'),
      );

      request.headers['Authorization'] = 'Basic VHVybmlrZXRCaXRyaXhCYXNpY0F1dGg6U3F2TWdBaHpHV3dEWWNIYjNa';

      var file = await http.MultipartFile.fromPath('file', image.path);
      request.files.add(file);

      var response = await request.send();

      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        try {
          Map<String, dynamic> responseObj = jsonDecode(responseBody);
          log("Response $responseObj");

          // if (responseObj['success'] == true) {
            String photoId = responseObj['data']['id'];
            log('Photo uploaded successfully! Photo ID: $photoId');

            ref.read(homeVMProvider).updatePhotoId(photoId);
            log("==================== updatePhotoId: $photoId =======================");

            return;
          // } else {
          //   log('Failed to upload photo: ${responseObj['message']}');
          // }
        } catch (e) {
          log('Unexpected response format: ');
        }
      } else {
        log('Failed to upload photo: ${response.statusCode}');
      }
    } catch (e) {
      log('Error uploading photo: $e');
    }
    context.go(AppRouteName.homePage);
  }

  Future<void> _takePicture() async {
    log("======================_takePicture=======================");
    try {
      await _initializeControllerFuture;

      final XFile image = await _controller.takePicture();

      _uploadPhoto(image);
    } catch (e) {
      log('Error taking picture: $e');
    }
    context.go(AppRouteName.homePage);
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
            color: Colors.transparent,
            child: Text(
              '$_countdown',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
