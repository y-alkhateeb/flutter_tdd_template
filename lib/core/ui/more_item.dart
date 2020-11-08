import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import '../../core/common/app_colors.dart';
import '../../core/common/dimens.dart';

class MoreItem extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onPressed;

  const MoreItem({
    Key key,
    @required this.image,
    @required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          highlightColor: Colors.transparent,
          splashColor: AppColors.accentColor.withOpacity(0.3),
          onPressed: onPressed ?? () {},
          child: ListTile(
            leading: Image.asset(
              image,
              color: AppColors.primaryColor,
              height: 30,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(Dimens.font_sp28)
              ),
            ),
          ),
        ),
        Divider(
          indent: 1,
        ),
      ],
    );
  }
}
