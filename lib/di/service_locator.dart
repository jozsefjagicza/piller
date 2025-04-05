

import 'package:get_it/get_it.dart';
import 'package:piller/interactors/auth_interactor.dart';
import 'package:piller/interactors/favorites_interactor.dart';
import 'package:piller/interactors/home_interactor.dart';
import 'package:piller/interactors/movie_details_interactor.dart';
import 'package:piller/providers/auth_provider.dart';
import 'package:piller/providers/favorites_provider.dart';
import 'package:piller/providers/home_provider.dart';
import 'package:piller/providers/movie_details_provider.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton<AuthProvider>(() => AuthProvider());
  locator.registerLazySingleton<HomeProvider>(() => HomeProvider());
  locator.registerLazySingleton<MovieDetailsProvider>(() => MovieDetailsProvider());
  locator.registerLazySingleton<FavoritesProvider>(() => FavoritesProvider());

  locator.registerLazySingleton<AuthInteractor>(() => AuthInteractor());
  locator.registerLazySingleton<HomeInteractor>(() => HomeInteractor());
  locator.registerLazySingleton<MovieDetailsInteractor>(() => MovieDetailsInteractor());
  locator.registerLazySingleton<FavoritesInteractor>(() => FavoritesInteractor());

}
