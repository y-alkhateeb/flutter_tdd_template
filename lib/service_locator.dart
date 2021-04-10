import 'package:get_it/get_it.dart';
import 'core/net/http_client.dart';
import 'feature/account/data/datasources/iaccount_remote.dart';
import 'feature/account/data/repository/account_repository.dart';
import 'feature/account/domain/repository/iaccount_repository.dart';

final GetIt inject = GetIt.I;

Future<void> setupInjection() async {
  //Components
  inject.registerSingleton(HttpClient());
  /// here just register UserManagementRepository as a Singleton
  /// to get instance from this class and call when we need delete tokens
  inject.registerLazySingleton<AccountRepository>(() =>
      AccountRepository(inject<IAccountRemoteSource>()));

  // Account Repositories
  inject.registerFactory<IAccountRepository>(() => AccountRepository(inject<IAccountRemoteSource>()));


}