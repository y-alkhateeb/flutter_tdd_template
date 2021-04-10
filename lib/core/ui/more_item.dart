import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/common/app_colors.dart';
import '../../core/common/dimens.dart';

class MoreItem extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback? onPressed;

  const MoreItem({
    Key? key,
    required this.image,
    required this.title,
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
              textScaleFactor: 1.0,
              style: TextStyle(
                fontSize: Dimens.font_sp28.sp
              ),
            ),
          ),
        ),
        const Divider(
          indent: 1,
        ),
      ],
    );
  }
}
