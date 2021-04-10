import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_template/core/errors/base_error.dart';
import 'package:flutter_tdd_template/core/net/http_method.dart';
import 'package:flutter_tdd_template/feature/account/data/model/request/login_request.dart';
import 'package:flutter_tdd_template/feature/account/data/model/request/register_request.dart';
import 'package:flutter_tdd_template/feature/account/data/model/response/login_model.dart';
import 'package:flutter_tdd_template/feature/account/data/model/response/register_model.dart';

import 'iaccount_remote.dart';

class AccountRemoteSource extends IAccountRemoteSource {

  @override
  Future<Either<BaseError, LoginModel>> login(LoginRequest loginRequest) async {
    return await request<LoginModel, dynamic, Object>(
      converter: (json) => LoginModel.fromMap(json),
      method: HttpMethod.POST,
      url: "ACCOUNT_LOGIN",
      body: loginRequest.toMap(),
      cancelToken: loginRequest.cancelToken,
    );
  }

  @override
  Future<Either<BaseError, RegisterModel>> register(
      RegisterRequest registerRequest) async {
    return await request<RegisterModel, dynamic, Object>(
      converter: (json) => RegisterModel.fromMap(json),
      method: HttpMethod.POST,
      url: "ACCOUNT_REGISTER",
      body: registerRequest.toMap(),
      cancelToken: registerRequest.cancelToken,
    );
  }

}