import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fm/application/application.dart';
import 'package:flutter_fm/application/base/custom_bloc_observer.dart';
import 'package:flutter_fm/data/locals/hive_cache.dart';
import 'package:flutter_fm/di/dependency_injection.dart' as dependencyInjection;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  await initApp();
  await catchZoned(() {
    return Application();
  });
}

Future<void> catchZoned(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(await builder()),
        blocObserver: CustomBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInjection.configureInjection();
  await Hive.initFlutter();
  await HiveCache.instance.initHive();
  Intl.defaultLocale = 'en';
}
