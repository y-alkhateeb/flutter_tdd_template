import 'package:flutter_tdd_template/core/errors/base_error.dart';
import 'package:flutter_tdd_template/core/result/result.dart';
import 'package:flutter_tdd_template/core/usecases/usecase.dart';
import 'package:flutter_tdd_template/feature/account/data/model/request/register_request.dart';
import 'package:flutter_tdd_template/feature/account/data/model/response/register_model.dart';
import 'package:flutter_tdd_template/feature/account/domain/repository/iaccount_repository.dart';

class RegisterUseCase extends UseCase<RegisterModel, RegisterRequest>{
  final IAccountRepository accountRepository;

  RegisterUseCase(this.accountRepository);
  @override
  Future<Result<BaseError, RegisterModel>> call(RegisterRequest params) async =>
      await accountRepository.register(params);
}