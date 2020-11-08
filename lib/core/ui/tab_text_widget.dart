import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import '../common/dimens.dart';

class TabTextWidget extends StatelessWidget {
  final String txt;
  final String icon;

  const TabTextWidget({Key key, this.txt, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset(icon,scale: 4,),
        Text(
          txt,
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: ScreenUtil().setSp(Dimens.font_sp18)),
        ),
      ],
    );
  }
}
