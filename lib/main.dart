import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:piller/feature/movie_details/movie_details_screen.dart';
import 'package:piller/providers/auth_provider.dart';
import 'package:piller/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/constants.dart';
import 'di/service_locator.dart';
import 'feature/authentication/login_screen.dart';
import 'feature/home/home_screen.dart';
import 'feature/splash/splash_screen.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => SplashScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) => HomeScreen());
          case '/home/favorite':
            return MaterialPageRoute(builder: (_) => LoginScreen());
          case '/home/details':
            final movieId = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => MovieDetailsScreen(movieId: movieId),
            );
          default:
            return null;
        }
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