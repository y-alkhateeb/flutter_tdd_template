import 'package:flutter_tdd_template/core/errors/base_error.dart';
import 'package:flutter_tdd_template/core/repository/Repository.dart';
import 'package:flutter_tdd_template/core/result/result.dart';
import 'package:flutter_tdd_template/feature/account/data/model/login_model.dart';
import 'package:flutter_tdd_template/feature/account/data/model/register_model.dart';
import 'package:flutter_tdd_template/feature/account/data/model/request/login_request.dart';
import 'package:flutter_tdd_template/feature/account/data/model/request/register_request.dart';

abstract class IAccountRepository extends Repository{
  Future<Result<BaseError, LoginModel>> login(LoginRequest loginRequest);

  Future<Result<BaseError, RegisterModel>> register(
      RegisterRequest registerRequest);

}
