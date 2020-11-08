import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_tdd_template/core/common/Utils.dart';
import 'package:flutter_tdd_template/core/common/app_colors.dart';
import 'package:flutter_tdd_template/core/common/dimens.dart';
import 'package:flutter_tdd_template/core/common/gaps.dart';
import 'package:flutter_tdd_template/core/common/validators.dart';
import 'package:flutter_tdd_template/core/constants.dart';
import 'package:flutter_tdd_template/core/localization/flutter_localization.dart';
import 'package:flutter_tdd_template/core/localization/translations.dart';
import 'package:flutter_tdd_template/core/ui/g_text_form_field.dart';
import 'package:flutter_tdd_template/core/ui/show_error.dart';
import 'package:flutter_tdd_template/feature/account/data/datasources/account_remote.dart';
import 'package:flutter_tdd_template/feature/account/data/model/request/login_request.dart';
import 'package:flutter_tdd_template/feature/account/presentation/bloc/account_bloc.dart';
import 'package:flutter_tdd_template/feature/account/presentation/widget/custom_button_widget.dart';
import 'package:flutter_tdd_template/feature/home/screen/bottom_tab_bar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/LoginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _inAsyncCall = false;
  final FocusNode myFocusNodeUserName = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();

  final cancelToken = CancelToken();

  bool _passwordSecure = true;

  final _phoneOrEmailKey = new GlobalKey<FormFieldState<String>>();
  final _passwordKey = new GlobalKey<FormFieldState<String>>();
  final _phoneOrEmailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool turnPhoneOrEmailValidate = true;

  bool turnPasswordValidate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: const DecorationImage(
                image: const AssetImage(LOGIN_BACKGROUND), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: ModalProgressHUD(
              inAsyncCall: _inAsyncCall,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.dp32),
                child: BlocListener(
                  listenWhen: (p,c)=>p != c,
                  listener: (context, state) {
                    if (state is LoginAccountWaiting) {
                      setState(() {
                        _inAsyncCall = true;
                      });
                    }
                    if (state is LoginAccountSuccess) {
                      setState(() {
                        _inAsyncCall = false;
                      });
                      Navigator.of(context).pushReplacementNamed(BottomTabBar.routeName);
                    }  else if (state is LoginAccountGeneralFailure) {
                      setState(() {
                        _inAsyncCall = false;
                      });
                      ShowError.showErrorSnakBar(context, state.error, state);
                    }
                  },
                  cubit: BlocProvider.of<AccountBloc>(context),
                  child: Column(
                    children: <Widget>[
                      Gaps.vGap64,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "WELCOME",
                            style: TextStyle(
                              color: AppColors.lightFontColor,
                              fontSize: Dimens.font_sp38,
                            ),
                          ),
                        ],
                      ),
                      Gaps.vGap64,
                      AccountRemoteSource.loginMode == 1
                          ? _buildPhoneNumberField()
                          : _buildEmailField(),
                      Gaps.vGap32,
                      _buildPasswordField(),
                      Gaps.vGap128,
                      CustomButton(
                        color: AppColors.greenColor,
                        text: Translations.of(context).translate("Login"),
                        textColor: AppColors.lightFontColor,
                        onPressed: () {
                          sendRequest();
                        },
                      ),
                      Gaps.vGap64,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            Translations.of(context)
                                .translate("label_or_u_can"),
                            style: TextStyle(
                              color: AppColors.lightFontColor,
                              fontSize: ScreenUtil().setSp(Dimens.font_sp28),
                            ),
                          ),
                        ],
                      ),
                      Gaps.vGap64,
                      CustomButton(
                        color: AppColors.lightFontColor,
                        text:
                            Translations.of(context).translate("label_sign_up"),
                        textColor: AppColors.blueFontColor,
                        onPressed: () {
                          unFocus();
                          Navigator.of(context)
                              .pushNamed(RegisterScreen.routeName);
                        },
                      ),
                      Gaps.vGap64,
                      CustomButton(
                        color: AppColors.lightFontColor,
                        text:
                            Translations.of(context).translate("label_change_to_email_or_phone"),
                        textColor: AppColors.blueFontColor,
                        onPressed: () {
                          unFocus();
                          if(AccountRemoteSource.loginMode == 2){
                            AccountRemoteSource.loginMode = 1;
                            RestartWidget.restartApp(context);
                          }
                          else{
                            AccountRemoteSource.loginMode = 2;
                            RestartWidget.restartApp(context);
                          }
                        },
                      ),
                      Gaps.vGap64,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  unFocus() {
    unFocusList(focus: [
      myFocusNodeUserName,
      myFocusNodePassword,
    ]);
  }

  sendRequest() {
    unFocus();
    setState(() {
      turnPhoneOrEmailValidate = true;
      turnPasswordValidate = true;
    });
    if (_phoneOrEmailKey.currentState.validate()) {
      if (_passwordKey.currentState.validate()) {
        BlocProvider.of<AccountBloc>(context).add(
          LoginAccountEvent(LoginRequest(
            phoneNumber:_phoneOrEmailController.text.
            replaceAll(RegExp("[^0-9]"), ""),
            email: _phoneOrEmailController.text,
            password: _passwordController.text,
            cancelToken: cancelToken,
          )),
        );
      }
    }
  }

  _buildPhoneNumberField() {
    return GTextFormField(
      formKey: _phoneOrEmailKey,
      controller: _phoneOrEmailController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      focusNode: myFocusNodeUserName,
      labelText: Translations.of(context).translate('label_phone'),
      hintText: "09X-XXX-XXXX",
      validator: (value) {
        if (turnPhoneOrEmailValidate) {
          if (Validators.isValidPhoneNumber(value))
            return null;
          else
            return Translations.of(context).translate('error_inValid_phone');
        } else
          return null;
      },
      onFieldSubmitted: (term) {
        fieldFocusChange(context, myFocusNodeUserName, myFocusNodePassword);
      },
      onChanged: (val) {
        if (turnPhoneOrEmailValidate) {
          setState(() {
            turnPhoneOrEmailValidate = false;
          });
          _phoneOrEmailKey.currentState.validate();
        }
      },
    );
  }

  _buildEmailField() {
    return GTextFormField(
      formKey: _phoneOrEmailKey,
      controller: _phoneOrEmailController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      focusNode: myFocusNodeUserName,
      labelText: Translations.of(context).translate('label_email'),
      validator: (value) {
        if (turnPhoneOrEmailValidate) {
          if (Validators.isValidEmail(value))
            return null;
          else
            return Translations.of(context).translate('error_inValid_email');
        } else
          return null;
      },
      onFieldSubmitted: (term) {
        fieldFocusChange(context, myFocusNodeUserName, myFocusNodePassword);
      },
      onChanged: (val) {
        if (turnPhoneOrEmailValidate) {
          setState(() {
            turnPhoneOrEmailValidate = false;
          });
          _phoneOrEmailKey.currentState.validate();
        }
      },
    );
  }

  _buildPasswordField() {
    return GTextFormField(
      formKey: _passwordKey,
      controller: _passwordController,
      textInputAction: TextInputAction.go,
      keyboardType: TextInputType.text,
      focusNode: myFocusNodePassword,
      labelText: Translations.of(context).translate('label_password'),
      suffixIcon: IconButton(
          icon: Icon(
            _passwordSecure ? Icons.visibility : Icons.visibility_off,
            color: AppColors.lightFontColor,
          ),
          onPressed: () {
            setState(() {
              _passwordSecure = !_passwordSecure;
            });
          }),
      validator: (value) {
        if (turnPasswordValidate) {
          if (Validators.isValidPassword(value))
            return null;
          else
            return Translations.of(context).translate('error_password_short');
        } else
          return null;
      },
      onFieldSubmitted: (term) {
        sendRequest();
      },
      onChanged: (val) {
        if (turnPasswordValidate) {
          setState(() {
            turnPasswordValidate = false;
          });
          _passwordKey.currentState.validate();
        }
      },
      obscureText: _passwordSecure,
    );
  }

  @override
  void dispose() {
    super.dispose();
    cancelToken.cancel();
    _phoneOrEmailController.dispose();
    _passwordController.dispose();
    myFocusNodeUserName.dispose();
    myFocusNodePassword.dispose();
  }
}