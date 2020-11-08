import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:flutter_tdd_template/core/errors/base_error.dart';
import 'package:flutter_tdd_template/core/errors/connection_error.dart';
import 'package:flutter_tdd_template/core/errors/custom_error.dart';
import 'package:flutter_tdd_template/core/errors/unknown_error.dart';

import 'package:flutter_tdd_template/feature/account/data/model/login_model.dart';

import 'package:flutter_tdd_template/feature/account/data/model/register_model.dart';

import 'package:flutter_tdd_template/feature/account/data/model/request/login_request.dart';

import 'package:flutter_tdd_template/feature/account/data/model/request/register_request.dart';

import 'account_remote.dart';
import 'iaccount_remote.dart';

class AccountFirebaseSource extends IAccountRemoteSource {
  @override
  Future<Either<BaseError, LoginModel>> login(LoginRequest loginRequest) async {
    try {
      if (AccountRemoteSource.loginMode == 1) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "${loginRequest.phoneNumber}@phone.com",
          password: loginRequest.password,
        );
      } else
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginRequest.email,
          password: loginRequest.password,
        );
      return Right(LoginModel(
          token: await FirebaseAuth.instance.currentUser.getIdToken()));
    } on PlatformException catch(e){
      return Left(CustomError(message: e.details[0]));
    }
    on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found")
        return Left(CustomError(message: "User not found"));
      if (e.code == "user-disabled")
        return Left(CustomError(message: "User disabled"));
      if (e.code == "wrong-password" || e.code == "invalid-email")
        return Left(CustomError(message: "Wrong email or password"));
      if(e.code == "network-request-failed"){
        return Left(ConnectionError());
      }
      else
        return Left(CustomError(message: e.message));
    } catch (e) {
      if(e is PlatformException){
        if(e.code == "firebase_auth"){
          return Left(CustomError(message: e.message));
        }
      }
      return Left(UnknownError());
    }
  }

  @override
  Future<Either<BaseError, RegisterModel>> register(
      RegisterRequest registerRequest) async {
    try {
      if (AccountRemoteSource.loginMode == 1) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: "${registerRequest.phoneNumber}@phone.com",
          password: registerRequest.password,
        );
      } else
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registerRequest.email,
          password: registerRequest.password,
        );
      return Right(RegisterModel());
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use")
        return Left(CustomError(message: "Email already in use"));
      else if (e.code == "operation-not-allowed")
        return Left(CustomError(message: "Operation not allowed"));
      else
        return Left(UnknownError());
    } catch (e) {
      return Left(UnknownError());
    }
  }
}
