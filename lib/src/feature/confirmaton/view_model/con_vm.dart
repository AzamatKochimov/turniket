import "dart:convert";
import "dart:developer";

import "package:camera/camera.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:time_pad/src/common/server/api/api.dart";
import "package:time_pad/src/common/server/api/api_constants.dart";

AutoDisposeChangeNotifierProvider<ConVM> conVM =
    ChangeNotifierProvider.autoDispose<ConVM>((ChangeNotifierProviderRef<ConVM> ref) => ConVM());

class ConVM with ChangeNotifier {

}
