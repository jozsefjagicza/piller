import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:piller/providers/auth_provider.dart';
import 'package:piller/providers/home_provider.dart';
import 'package:provider/provider.dart';

import 'di/service_locator.dart';
import 'feature/authentication/login_screen.dart';
import 'feature/home/home_screen.dart';
import 'feature/splash/splash_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  setupLocator();

  runApp(
      EasyLocalization(
        supportedLocales: [Locale('en'), Locale('hu')],
        path: 'assets/translations',
        fallbackLocale: Locale('hu'),
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => locator<AuthProvider>(),
              ),
              ChangeNotifierProvider(
                create: (_) => locator<HomeProvider>(),
              ),
        ],
        child: MyApp()),
          )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
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