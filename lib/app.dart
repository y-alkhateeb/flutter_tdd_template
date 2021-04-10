import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'aplash.dart';
import 'core/common/app_colors.dart';
import 'core/constants.dart';
import 'core/localization/localization_provider.dart';
import 'core/route/route_generator.dart';
import 'feature/account/presentation/bloc/account_bloc.dart';
import 'generated/l10n.dart';

final navigationKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  final LocalizationProvider appLanguage;

  const App({Key? key,required this.appLanguage}) : super(key: key);

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
      child: Consumer<LocalizationProvider>(
        builder: (_, provider, __) {
          return ScreenUtilInit(
            designSize: Size(750, 1334),
            builder: ()=> MaterialApp(
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
              supportedLocales: S.delegate.supportedLocales,
              locale: provider.appLocal,
              // These delegates make sure that the localization data for the proper language is loaded
              localizationsDelegates: [
                // 1
                S.delegate,
                // 2
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
