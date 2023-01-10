import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/const.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.buttonTitle,
    required this.onBtnPress,
    this.btnColor,
  });
  final Color? btnColor;
  final String buttonTitle;
  final VoidCallback? onBtnPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      child: CupertinoButton(
        padding: EdgeInsets.symmetric(vertical: 14),
        color: btnColor ?? primaryColor,
        child: Text(
          buttonTitle,
          textScaleFactor: 1.0,
          style: TextStyle(fontSize: 17),
        ),
        onPressed: onBtnPress,
      ),
    );
  }
}
