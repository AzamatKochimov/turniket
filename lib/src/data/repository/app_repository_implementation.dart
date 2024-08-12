import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../common/server/api/api.dart';
import '../../common/server/api/api_constants.dart';
import 'app_repository.dart';

@immutable
class AppRepositoryImpl implements AppRepository {
  const AppRepositoryImpl._internal();

  @override
  Future<void> uploadProfileImage(File image) async {
    try {
      await ApiService.multipart(ApiConst.uploadAvatar, [image]);
    } catch (e) {
      // Handle any errors that occur during the upload
      throw Exception('Failed to upload profile image: $e');
    }
  }
}

