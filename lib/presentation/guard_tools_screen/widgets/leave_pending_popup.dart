import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:sgt/presentation/guard_tools_screen/widgets/cancel_leave_request_popup.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_text_widget.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';

class LeavePendingInfo extends StatelessWidget {
  String reason;
  String statusOfLeave;
  String leaveId;
  LeavePendingInfo({
    super.key,
    required this.reason,
    required this.statusOfLeave,
    required this.leaveId,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        // height: 138.h,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(12, 12),
                      topRight: Radius.elliptical(12, 12)),
                  color: CustomTheme.primaryColor,
                ),
                child: Center(
                  child: Text(
                    'Pending',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: CustomTheme.white),
                  ),
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(12, 12),
                    bottomRight: Radius.elliptical(12, 12)),
                color: CustomTheme.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusOfLeave == 'Pending' ? 'Leave Subject' : '',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    textScaleFactor: 1.0,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    reason,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: CustomTheme.black.withOpacity(0.4)),
                    textScaleFactor: 1.0,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 14),
                        color: CustomTheme.primaryColor,
                        child: Text(
                          'Go back',
                          textScaleFactor: 1.0,
                          style: TextStyle(fontSize: 17),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CancelLeaveRequest(
                                  leaveId:leaveId
                                );
                              });
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: AppColors.redColor),
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
