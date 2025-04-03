import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'feature/splash/splash_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp( EasyLocalization(
    supportedLocales: [Locale('en'), Locale('hu')],
    path: 'assets/translations',
    fallbackLocale: Locale('hu'),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: AuthHandler(),
    );
  }
}

class AuthHandler extends StatelessWidget {
  const AuthHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}