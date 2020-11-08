import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_template/core/datasource/remote_data_source.dart';
import 'package:flutter_tdd_template/core/errors/base_error.dart';
import 'package:flutter_tdd_template/feature/account/data/model/login_model.dart';
import 'package:flutter_tdd_template/feature/account/data/model/register_model.dart';
import 'package:flutter_tdd_template/feature/account/data/model/request/login_request.dart';
import 'package:flutter_tdd_template/feature/account/data/model/request/register_request.dart';

abstract class IAccountRemoteSource extends RemoteDataSource {

  Future<Either<BaseError, LoginModel>> login(LoginRequest loginRequest);

  Future<Either<BaseError, RegisterModel>> register(
      RegisterRequest registerRequest);
}
