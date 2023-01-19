import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../theme/custom_theme.dart';

// ignore: must_be_immutable
class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({
    super.key,
    required this.buttonTitle,
    required this.onBtnPress,
    this.isValid = true,
    this.btnColor,
  });
  final Color? btnColor;
  final String buttonTitle;
  final VoidCallback? onBtnPress;
  bool isValid;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      child: CupertinoButton(
        padding: EdgeInsets.symmetric(vertical: 14),
        color: isValid ? CustomTheme.primaryColor : CustomTheme.seconderyColor,
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
