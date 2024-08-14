import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Confirmation extends StatefulWidget {
  const Confirmation({super.key});

  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int _countdown = 5; // Countdown starts from 5
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
    setState(() {});

    // Start the countdown timer once the camera is initialized
    if (mounted) {
      _startCountdown();
    }
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        if (_countdown > 5) {
          _countdown--;
        } else {
          _takePicture();
          timer.cancel();
        }
      });
    });
  }

  Future<void> _uploadPhoto(XFile image) async {
    try {
      // Convert the image to base64
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Prepare the request body
      final body = jsonEncode({
        'image_base64': base64Image,
      });

      // Send the POST request
      final response = await http.post(
        Uri.parse('https://your-api-endpoint.com/api/attachment/v1/attachment/upload'),
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Basic VHVybmlrZXRCaXRyaXhCYXNpY0F1dGg6U3F2TWdBaHpHV3dEWWNIYjNa',
        },
        body: body,
      );

      log("Status code: ${response.statusCode}");
      log("response body: ${response.body}");



      if (response.statusCode == 200) {
        print('Photo uploaded successfully!');
      } else {
        print('Failed to upload photo: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading photo: $e');
    }
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      final XFile image = await _controller.takePicture();


      _uploadPhoto(image);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPicturePage(imagePath: image.path),
        ),
      );
    } catch (e) {
      print('Error taking picture: $e');
    }
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
            child: Text(
              '$_countdown',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayPicturePage extends StatelessWidget {
  final String imagePath;

  const DisplayPicturePage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Captured Picture')),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
