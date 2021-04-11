import 'package:flutter/material.dart';
import 'app.dart';
import 'core/common/appConfig.dart';
import 'core/localization/localization_provider.dart';
import 'di/service_locator.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _appLanguage = LocalizationProvider();
  setupInjection();
  // Init Language.
  await _appLanguage.fetchLocale();
  AppConfig().initVersion();
  runApp(
    App(
      appLanguage: _appLanguage,
    ),
  );
}