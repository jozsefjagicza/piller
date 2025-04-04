

import 'package:get_it/get_it.dart';
import 'package:piller/interactors/auth_interactor.dart';
import 'package:piller/interactors/home_interactor.dart';
import 'package:piller/providers/auth_provider.dart';
import 'package:piller/providers/home_provider.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton<AuthProvider>(() => AuthProvider());
  locator.registerLazySingleton<HomeProvider>(() => HomeProvider());

  locator.registerLazySingleton<AuthInteractor>(() => AuthInteractor());
  locator.registerLazySingleton<HomeInteractor>(() => HomeInteractor());

}