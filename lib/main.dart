import 'package:flutter/material.dart';
import 'app.dart';
import 'core/common/appConfig.dart';
import 'core/localization/localization_provider.dart';
import 'service_locator.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _appLanguage = LocalizationProvider();
  // Init Language.
  await _appLanguage.fetchLocale();
  AppConfig().initVersion();
  setupInjection();
  runApp(
    App(
      appLanguage: _appLanguage,
    ),
  );
}