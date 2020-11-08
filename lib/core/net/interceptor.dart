import 'package:dio/dio.dart';
import '../../feature/account/data/repository/account_repository.dart';
import '../common/appConfig.dart';
import '../constants.dart';

class LanguageInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    // Get the language.
    String lang  = await appConfig.currentLanguage();
    if (lang.isNotEmpty) {
      options.headers[HEADER_LANGUAGE] = lang;
      print(options.headers);
    }

    return super.onRequest(options);
  }
}

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    if (await AccountRepository.hasToken) {
      final token = await AccountRepository.authToken;
      if (token.isNotEmpty) {
        options.headers[HEADER_AUTH] = '$token';
      }
    }
    print(options.headers);
    return super.onRequest(options);
  }
}
