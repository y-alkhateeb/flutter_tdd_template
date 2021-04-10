import 'package:dio/dio.dart';
import 'package:flutter_tdd_template/core/common/appConfig.dart';
import '../../feature/account/data/repository/account_repository.dart';
import '../constants.dart';

class LanguageInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
    // Get the language.
    String lang  = await AppConfig().currentLanguage();
    if (lang.isNotEmpty) {
      options.headers[HEADER_LANGUAGE] = lang;
      print(options.headers);
    }

    return super.onRequest(options,handler);
  }
}

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (await AccountRepository.hasToken) {
      final token = await AccountRepository.authToken;
      if (token.isNotEmpty) {
        options.headers[HEADER_AUTH] = '$token';
      }
    }
    return super.onRequest(options, handler);
  }
}
