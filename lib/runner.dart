import "dart:async";
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
