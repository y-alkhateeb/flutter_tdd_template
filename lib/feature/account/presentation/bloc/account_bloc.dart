import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tdd_template/core/constants.dart';
import 'package:flutter_tdd_template/core/errors/base_error.dart';
import 'package:flutter_tdd_template/core/model/error_message_model.dart';
import 'package:flutter_tdd_template/feature/account/data/datasources/account_remote.dart';
import 'package:flutter_tdd_template/feature/account/data/model/request/login_request.dart';
import 'package:flutter_tdd_template/feature/account/data/model/request/register_request.dart';
import 'package:flutter_tdd_template/feature/account/domain/repository/iaccount_repository.dart';
import 'package:flutter_tdd_template/feature/account/domain/usecase/login_usecase.dart';
import 'package:flutter_tdd_template/feature/account/domain/usecase/register_usecase.dart';

import '../../../../service_locator.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event,) async* {
    if (event is LoginAccountEvent) {
      yield LoginAccountWaiting();
      final data = await LoginUseCase(inject<IAccountRepository>())(
          AccountRemoteSource.loginMode==1?LoginRequest(
            cancelToken: event.loginRequest.cancelToken,
            phoneNumber: event.loginRequest.phoneNumber,
            password: event.loginRequest.password,
          ):
          LoginRequest(
            cancelToken: event.loginRequest.cancelToken,
            email: event.loginRequest.email,
            password: event.loginRequest.password,
          )
      );
      if (data.hasErrorOnly) {
        final error = data.error;
        if (error is ErrorMessageModel) {
          yield LoginAccountGeneralFailure(
              error,
                  () {
                this.add(event);
              }
          );

        }
        else {
          yield LoginAccountGeneralFailure(
              error,
                  () {
                this.add(event);
              }
          );
        }
      }
      if (data.hasDataOnly) {
        yield LoginAccountSuccess();
      }
    }

    if (event is RegisterAccountEvent) {
      yield RegisterAccountWaiting();
      final data = await RegisterUseCase(inject<IAccountRepository>())(
          AccountRemoteSource.loginMode==1?RegisterRequest(
            firstName: event.registerRequest.firstName,
            lastName: event.registerRequest.lastName,
            cancelToken: event.registerRequest.cancelToken,
            phoneNumber: event.registerRequest.phoneNumber,
            password: event.registerRequest.password,
          ):
          RegisterRequest(
            firstName: event.registerRequest.firstName,
            lastName: event.registerRequest.lastName,
            email: event.registerRequest.email,
            password: event.registerRequest.password,
            cancelToken: event.registerRequest.cancelToken,
          )
      );
      if (data.hasErrorOnly) {
        final error = data.error;
        if (error is ErrorMessageModel) {
          yield RegisterAccountGeneralFailure(
              error,
                  () {
                this.add(event);
              }
          );

        }
        else {
          yield RegisterAccountGeneralFailure(
              error,
                  () {
                this.add(event);
              }
          );
        }
      }
      if (data.hasDataOnly) {
        yield RegisterAccountSuccess();
      }
    }

  }
}