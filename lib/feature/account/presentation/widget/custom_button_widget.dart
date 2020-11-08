import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_tdd_template/core/common/dimens.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final Color textColor;
  final Function onPressed;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  const CustomButton({Key key, this.color, this.text, this.textColor, this.onPressed, this.fontSize, this.padding}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: padding,
      borderRadius: BorderRadius.circular(30),
      color: color,
      pressedOpacity: 0.7,
      child: Text(
        text,
        style: TextStyle(
            color: textColor,
            fontSize: fontSize??ScreenUtil().setSp(Dimens.font_sp28)),
      ),
      onPressed: onPressed,
    );
  }
}
