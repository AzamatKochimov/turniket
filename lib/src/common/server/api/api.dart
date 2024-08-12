import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:l/l.dart';

import '../../local/app_storage.dart';
import '../interceptors/connectivity_interceptor.dart';
import 'api_connection.dart';
import 'api_constants.dart';

@immutable
class ApiService {
  const ApiService._();

  static Future<Dio> initDio() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
        headers: await ApiService.getHeaders(),
        connectTimeout: const Duration(seconds: ApiConst.connectionTimeout),
        receiveTimeout: const Duration(seconds: ApiConst.connectionTimeout),
        sendTimeout: const Duration(seconds: ApiConst.sendTimeout),
        validateStatus: (status) => status != null && status < 205,
      ),
    );

    dio.interceptors.addAll(
      [
        ConnectivityInterceptor(
          requestRetrier: Connection(
            dio: dio,
            connectivity: Connectivity(),
          ),
        ),
      ],
    );

    return dio;
  }

  static Future<Map<String, String>> getHeaders({bool isUpload = false}) async {
    final headers = <String, String>{
      'Content-type':
          isUpload ? 'multipart/form-data' : 'application/json; charset=UTF-8',
      'Accept':
          isUpload ? 'multipart/form-data' : 'application/json; charset=UTF-8',
    };

    final token = await AppStorage.$read(key: StorageKey.token) ?? '';

    if (token.isNotEmpty) {
      headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }

    return headers;
  }

  // static Future<String?> get(String api, [Map<String, dynamic>? params]) async {
  //   try {
  //     final Response<dynamic> response =
  //         await (await initDio()).get<dynamic>(api, queryParameters: params);
  //     return jsonEncode(response.data);
  //   } on TimeoutException catch (_) {
  //     l.e("The connection has timed out, Please try again!");
  //     rethrow;
  //   } on DioError catch (e) {
  //     l.e(e.response.toString());
  //     rethrow;
  //   } on Object catch (e) {
  //     l.e(e.toString());
  //     rethrow;
  //   }
  // }
  static Future<String?> get(String api, [Map<String, dynamic>? params, Map<String, String>? additionalHeaders]) async {
    try {
      final Dio dio = await initDio();
      dio.options.headers.addAll(additionalHeaders ?? {});

      final Response<dynamic> response =
      await dio.get<dynamic>(api, queryParameters: params);
      return jsonEncode(response.data);
    } on TimeoutException catch (_) {
      l.e("The connection has timed out, Please try again!");
      rethrow;
    } on DioException catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (e) {
      l.e(e.toString());
      rethrow;
    }
  }


  static Future<String?> post(String api, Map<String, dynamic> data,
      {required Map<String, dynamic> params}) async {
    try {
      // final AppStorage prefs = await AppStorage.getInstance();
      // String? token = await AppStorage.$read(key: StorageKey.token);
      String basicAuth = 'Basic ${base64Encode(utf8.encode('TurniketBitrixBasicAuth:SqvMgAhzGWwDYcHb3Z'))}';
      final response = await (await initDio()).post<dynamic>(
        api,
        data: data,
        queryParameters: params,
        options: Options(
          headers: {
            'Authorization': basicAuth,
            'Content-type': 'application/json; charset=UTF-8',
            'Accept': 'application/json; charset=UTF-8',
          },
        ),
      );
      return jsonEncode(response.data);
    } on TimeoutException catch (_) {
      l.e('The connection has timed out, Please try again!');
      rethrow;
    } on DioException catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (_) {
      rethrow;
    }
  }

  static Future<String?> multipart(
    String api,
    List<File> paths, {
    bool picked = false,
  }) async {
    final formData = paths.mappedFormData(isPickedFile: picked);

    try {
      final response = await Dio(
        BaseOptions(
          baseUrl: ApiConst.baseUrl,
          validateStatus: (status) => status! < 203,
          headers: await getHeaders(isUpload: true),
        ),
      ).post<String?>(
        api,
        data: formData,
        onSendProgress: (int sentBytes, int totalBytes) {
          final progressPercent = sentBytes / totalBytes * 100;
          l.i('Progress: $progressPercent %');
        },
        onReceiveProgress: (int sentBytes, int totalBytes) {
          final progressPercent = sentBytes / totalBytes * 100;
          l.i('Progress: $progressPercent %');
        },
      ).timeout(
        const Duration(minutes: 10),
        onTimeout: () {
          throw TimeoutException(
            'The connection has timed out, Please try again!',
          );
        },
      );

      return jsonEncode(response.data);
    } on DioException catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (_) {
      rethrow;
    }
  }

  static Future<String?> put(String api, Map<String, dynamic> data) async {
    try {
      final response = await (await initDio()).put<dynamic>(api, data: data);

      return jsonEncode(response.data);
    } on TimeoutException catch (_) {
      l.e('The connection has timed out, Please try again!');
      rethrow;
    } on DioException catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (_) {
      rethrow;
    }
  }

  static Future<String?> putAccount(
    String api,
    Map<String, dynamic> params,
  ) async {
    try {
      final response =
          await (await initDio()).put<dynamic>(api, queryParameters: params);

      return jsonEncode(response.data);
    } on TimeoutException catch (_) {
      l.e('The connection has timed out, Please try again!');
      rethrow;
    } on DioException catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (_) {
      rethrow;
    }
  }

  static Future<String?> delete(String api) async {
    try {
      final _ = await (await initDio()).delete<dynamic>(api);
      return 'success';
    } on TimeoutException catch (_) {
      l.e('The connection has timed out, Please try again!');
      rethrow;
    } on DioException catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (_) {
      rethrow;
    }
  }
}

extension ListFileToFormData on List<File> {
  Future<FormData> mappedFormData({required bool isPickedFile}) async =>
      FormData.fromMap(
        <String, MultipartFile>{
          for (var v in this) ...{
            DateTime.now().toString(): MultipartFile.fromBytes(
              isPickedFile
                  ? v.readAsBytesSync()
                  : (await rootBundle.load(v.path)).buffer.asUint8List(),
              filename: v.path.substring(v.path.lastIndexOf('/')),
            ),
          },
        },
      );
}
