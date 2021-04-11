import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tdd_template/core/errors/base_error.dart';
import 'package:flutter_tdd_template/feature/account/data/model/request/login_request.dart';
import 'package:flutter_tdd_template/feature/account/data/model/request/register_request.dart';
import 'package:flutter_tdd_template/feature/account/domain/repository/iaccount_repository.dart';
import 'package:flutter_tdd_template/feature/account/domain/usecase/login_usecase.dart';
import 'package:flutter_tdd_template/feature/account/domain/usecase/register_usecase.dart';
import 'package:get_it/get_it.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event,) async* {
    if (event is LoginAccountEvent) {
      yield LoginAccountWaiting();
      final data = await LoginUseCase(GetIt.I<IAccountRepository>())(
          LoginRequest(
            cancelToken: event.loginRequest.cancelToken,
            phoneNumber: event.loginRequest.phoneNumber,
            email: event.loginRequest.email,
            password: event.loginRequest.password,
          )
      );
      if (data.hasErrorOnly) {
          yield LoginAccountGeneralFailure(
              data.error!,
                  () {
                this.add(event);
              }
          );
      }
      if (data.hasDataOnly) {
        yield LoginAccountSuccess();
      }
    }

    if (event is RegisterAccountEvent) {
      yield RegisterAccountWaiting();
      final data = await RegisterUseCase(GetIt.I<IAccountRepository>())(
          RegisterRequest(
            firstName: event.registerRequest.firstName,
            lastName: event.registerRequest.lastName,
            cancelToken: event.registerRequest.cancelToken,
            phoneNumber: event.registerRequest.phoneNumber,
            email: event.registerRequest.email,
            password: event.registerRequest.password,
          )
      );
      if (data.hasErrorOnly) {
          yield RegisterAccountGeneralFailure(
              data.error!,
                  () {
                this.add(event);
              }
          );
      }
      if (data.hasDataOnly) {
        yield RegisterAccountSuccess();
      }
    }

  }
}