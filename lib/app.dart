import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'aplash.dart';
import 'core/common/app_colors.dart';
import 'core/constants.dart';
import 'core/localization/localization_provider.dart';
import 'core/localization/restart_widget.dart';
import 'core/localization/translations.dart';
import 'core/route/route_generator.dart';
import 'feature/account/presentation/bloc/account_bloc.dart';

final navigationKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  final AppConfigProvider appLanguage;

  const App({Key key, this.appLanguage}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: widget.appLanguage,
        ),
        BlocProvider(
          create: (_) => AccountBloc(),
          lazy: true,
        ),
      ],
      child: Consumer<AppConfigProvider>(
        builder: (_, provider, __) {
          return RestartWidget(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: TITLE_APP_NAME,
              themeMode: ThemeMode.light,
              // set this Widget as root
              initialRoute: '/',
              navigatorKey: navigationKey,
              onGenerateRoute: RouteGenerator.generateRoute,
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  color: AppColors.primaryColor,
                ),
                primaryColor: AppColors.primaryColor,
                accentColor: AppColors.accentColor,
                snackBarTheme: const SnackBarThemeData(
                  actionTextColor: AppColors.white_text,
                  backgroundColor: AppColors.accentColor,
                  behavior: SnackBarBehavior.fixed,
                  elevation: 5.0,
                ),
                scaffoldBackgroundColor: AppColors.backgroundColor,
              ),
              supportedLocales: [
                // first
                const Locale(LANG_EN),
                // last
                const Locale(LANG_AR),
              ],
              locale: provider.appLocal,
              // These delegates make sure that the localization data for the proper language is loaded
              localizationsDelegates: [
                Translations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
                home: Splash(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<AccountBloc>(context).close();
  }
}
