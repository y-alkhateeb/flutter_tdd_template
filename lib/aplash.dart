import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/common/app_colors.dart';
import 'core/common/dimens.dart';
import 'feature/account/data/repository/account_repository.dart';
import 'feature/account/presentation/screen/login_screen.dart';
import 'feature/home/screen/bottom_tab_bar.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    checkToken();
    super.initState();
  }

  checkToken(){
    Future.delayed(
        const Duration(seconds: 4),
        () async {
          if(await AccountRepository.hasToken){
            Navigator.of(context).pushReplacementNamed(BottomTabBar.routeName);
          }
          else Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Center(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextLiquidFill(
                    boxHeight: 300.h,
                    text: "FLUTTER TDD TEMPLATE",
                    loadDuration: const Duration(seconds: 4),
                    waveDuration: const Duration(seconds: 2),
                    waveColor: AppColors.primaryColor,
                    boxBackgroundColor: Colors.white,
                    textStyle: TextStyle(
                          color: AppColors.greenColor,
                        fontSize: ScreenUtil().setSp(Dimens.font_sp38+Dimens.font_sp14),
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}