import "dart:async";
import "dart:io";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:l/l.dart";
import "setup.dart";
import "src/app.dart";
import "src/common/utils/error_util.dart";

void run() => l.capture<void>(
      () => runZonedGuarded<Future<void>>(
        () async {
      await setup();
      runApp(const ProviderScope(child: App()));
      HttpOverrides.global = MyHttpOverrides();
    },
        (Object error, StackTrace stackTrace) => ErrorUtil.logError(
      error,
      stackTrace,
      hint: "ROOT | ",
    ),
  ),

  const LogOptions(
    outputInRelease: true,
  ),
);

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}