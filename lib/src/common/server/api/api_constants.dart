class ApiConst {
  static const connectionTimeout = 20000;
  static const sendTimeout = 20000;

  static const baseUrl = 'https://api.pdp.uz';
  static const version = '';

  // Courses api
  static const login = '/api/auth/v1/user/me';
  static const user = '/api/turniket/v1/bitrix/inout/check';
  static const qrData = '/api/turniket/v1/bitrix/inout/event';
  static const photoId = '/api/attachment/v1/attachment/upload';

}

class ApiParams {
  const ApiParams._();

  static Map<String, dynamic> emptyParams() => <String, dynamic>{};
}
