import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'core/common/appConfig.dart';
import 'core/localization/localization_provider.dart';
import 'service_locator.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _appLanguage = AppConfigProvider();
  // Init Language.
  await _appLanguage.fetchLocale();
  appConfig.initVersion();
  Firebase.initializeApp();
  setupInjection();
  runApp(
    App(
      appLanguage: _appLanguage,
    ),
  );
}