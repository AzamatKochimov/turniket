import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_repository.dart';
import 'app_repository_implementation.dart';

final appRepositoryProvider = Provider<AppRepository>((ref) {
  return AppRepositoryImpl();
});
