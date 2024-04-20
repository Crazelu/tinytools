import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prettifier/core/data/secure_storage.dart';
import 'package:prettifier/core/data/local_cache.dart';
import 'package:prettifier/core/navigation/navigation_bus.dart';
import 'package:prettifier/core/dialog/dialog_handler.dart';
import 'package:prettifier/core/io/api_client.dart';
import 'package:prettifier/core/io/logging_interceptor.dart';
import 'package:prettifier/core/environment.dart';

class DependencyRegistry {
  DependencyRegistry._();

  static Future<void> register() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton(sharedPreferences);

    // Local storage
    GetIt.I.registerLazySingleton<SecureStorage>(
      () => SecureStorageImpl(),
    );

    GetIt.I.registerLazySingleton<LocalCache>(
      () => LocalCacheImpl(
        sharedPreferences: GetIt.I(),
        storage: GetIt.I(),
      ),
    );

    // Navigation
    GetIt.I.registerLazySingleton<NavigationBus>(() => NavigationBusImpl());

    // Dialog
    GetIt.I.registerLazySingleton<DialogHandler>(() => DialogHandlerImpl());

    // API
    GetIt.I.registerLazySingleton<ApiClient>(
      () => ApiClient(
        baseUrl: Environment.baseUrl,
        interceptors: [LoggingInterceptor()],
      ),
    );
  }
}
