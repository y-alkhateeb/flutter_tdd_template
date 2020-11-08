import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_tdd_template/core/common/Utils.dart';
import 'package:flutter_tdd_template/core/common/app_colors.dart';
import 'package:flutter_tdd_template/core/common/dimens.dart';
import 'package:flutter_tdd_template/core/constants.dart';
import 'package:flutter_tdd_template/core/lib/curved_navigation_bar.dart';
import 'package:flutter_tdd_template/core/localization/flutter_localization.dart';
import 'package:flutter_tdd_template/core/model/lanuage_model.dart';
import 'package:flutter_tdd_template/core/ui/more_item.dart';
import 'package:flutter_tdd_template/core/ui/show_dialog.dart';
import 'package:flutter_tdd_template/feature/account/presentation/widget/custom_button_widget.dart';
import 'package:provider/provider.dart';

class BottomTabBar extends StatefulWidget {
  static const routeName = "/BottomTabBar";

  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar>
    with SingleTickerProviderStateMixin {
  TabController tabControl;
  int _bottomNavigationBarIndex;

  @override
  void initState() {
    _bottomNavigationBarIndex = 2;
    tabControl = TabController(length: 4, vsync: this, initialIndex: 2)
      ..addListener(() {
        _onTapBottomNavigationBar(tabControl.index);
      });
    super.initState();
  }

  _onTapBottomNavigationBar(int index) {
    setState(() {
      _bottomNavigationBarIndex = index;
    });
    tabControl.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9fdff),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        items: _navBarsItems(),
        height: 50,
        color: AppColors.primaryColor,
        buttonBackgroundColor: AppColors.primaryColor,
        animationCurve: Curves.easeInOutQuint,
        animationDuration: const Duration(milliseconds: 300),
        index: _bottomNavigationBarIndex,
        onTap: (index) => _onTapBottomNavigationBar(index),
      ),
      body: TabBarView(
        controller: tabControl,
        physics: const BouncingScrollPhysics(),
        children: _buildScreens(),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text("SCREEN 1"),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text("SCREEN 2"),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("FLUTTER TDD TEMPLATE"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MoreItem(
              title: Translations.of(context).translate("label_change_language"),
              image: MENU_CHANGE_LANG,
              onPressed: ()=> _buildChangeLanguage(),
            ),
            MoreItem(
              title: Translations.of(context).translate("label_logout"),
              image: MENU_LOGOUT,
              onPressed: () async {
                await logout();
                logoutGoToLoginAndResetStateBlocProvider(context);
              },
            ),
          ],
        ),
      ),
      Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text("SCREEN 4"),
        ),
      ),
    ];
  }

  List<Widget> _navBarsItems() {
    return [
      Tab(
        child: Icon(
          Icons.notifications_active,
          color: AppColors.white,
          size: ScreenUtil().setWidth(60),
        ),
      ),
      Tab(
        child: Icon(
          Icons.person,
          color: AppColors.white,
          size: ScreenUtil().setWidth(60),
        ),
      ),
      Tab(
        child: Icon(
          Icons.home,
          color: AppColors.white,
          size: ScreenUtil().setWidth(60),
        ),
      ),
      Tab(
        child: Icon(
          Icons.more_vert,
          color: AppColors.white,
          size: ScreenUtil().setWidth(60),
        ),
      ),
    ];
  }

  _buildChangeLanguage(){
    int _currentLangValue = Translations.of(context).locale.languageCode==
        LANG_AR ? LanguageModel.getLanguage().first.languageId :
    LanguageModel.getLanguage().last.languageId;
    ShowDialog().showTransparentDialog(
        context: context,
        builder:(context){
          return StatefulBuilder(
            builder: (context, setState){
              return Dialog(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.40,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(60))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: LanguageModel.getLanguage().map((e) =>
                            RadioListTile(
                              groupValue: _currentLangValue,
                              value: e.languageId,
                              title: Text(e.languageName),
                              activeColor: AppColors.primaryColor,
                              onChanged: (val){
                                setState(() {
                                  _currentLangValue = val;
                                });
                              },
                            ),
                        ).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            color: AppColors.accentLightColor,
                            text: Translations.of(context).translate("label_cancel"),
                            textColor: Colors.white,
                            onPressed: ()=>Navigator.pop(context),
                            fontSize: ScreenUtil().setSp(Dimens.font_sp24),
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(64)),
                          ),
                          CustomButton(
                            color: AppColors.primaryColor,
                            text: Translations.of(context).translate("label_confirm"),
                            textColor: Colors.white,
                            onPressed: () {
                              Provider.of<AppConfigProvider>(context,listen: false).
                              changeLanguage(
                                LanguageModel.getLanguage()[_currentLangValue].locale,
                                context,
                              );
                            },
                            fontSize: ScreenUtil().setSp(Dimens.font_sp24),
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(64)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }
}
