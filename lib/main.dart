import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:piller/feature/favorites/favorites_screen.dart';
import 'package:piller/feature/movie_details/movie_details_screen.dart';
import 'package:piller/providers/auth_provider.dart';
import 'package:piller/providers/favorites_provider.dart';
import 'package:piller/providers/home_provider.dart';
import 'package:piller/providers/movie_details_provider.dart';
import 'package:provider/provider.dart';

import 'common/models/movie.dart';
import 'di/service_locator.dart';
import 'feature/authentication/login_screen.dart';
import 'feature/home/home_screen.dart';
import 'feature/splash/splash_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  setupLocator();

  runApp(
      EasyLocalization(
        supportedLocales: [Locale('en'), Locale('hu')],
        path: 'assets/translations',
        fallbackLocale: Locale('hu'),
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: locator<AuthProvider>(),
              ),
              ChangeNotifierProvider.value(
                value: locator<HomeProvider>(),
              ),
              ChangeNotifierProvider.value(
                value: locator<FavoritesProvider>(),
              ),
              ChangeNotifierProvider.value(
                value: locator<MovieDetailsProvider>(),
              ),
            ],
        child: MyApp()),
          )
  );
}

class ObserverUtils {
  static final RouteObserver<ModalRoute> routeObserver = RouteObserver<PageRoute<void>>();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      navigatorObservers: [ObserverUtils.routeObserver],
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
            return MaterialPageRoute(builder: (_) => FavoritesScreen());
          case '/home/details':
            final movie = settings.arguments as Movie;
            return MaterialPageRoute(
              builder: (_) => MovieDetailsScreen(movie: movie),
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