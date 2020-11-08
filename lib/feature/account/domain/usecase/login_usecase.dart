import 'package:flutter_tdd_template/core/errors/base_error.dart';
import 'package:flutter_tdd_template/core/result/result.dart';
import 'package:flutter_tdd_template/core/usecases/usecase.dart';
import 'package:flutter_tdd_template/feature/account/data/model/login_model.dart';
import 'package:flutter_tdd_template/feature/account/data/model/request/login_request.dart';
import 'package:flutter_tdd_template/feature/account/domain/repository/iaccount_repository.dart';

class LoginUseCase extends UseCase<LoginModel, LoginRequest>{
  final IAccountRepository accountRepository;

  LoginUseCase(this.accountRepository);
  @override
  Future<Result<BaseError, LoginModel>> call(LoginRequest params) async =>
      await accountRepository.login(params);
}