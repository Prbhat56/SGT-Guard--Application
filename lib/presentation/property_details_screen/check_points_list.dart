import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/check_point_screen/widgets/check_point_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import '../../utils/const.dart';
import 'widgets/check_points_lists_widget.dart';
import 'widgets/checkpoints_alert_dialog.dart';

class CheckPointListsScreen extends StatefulWidget {
  const CheckPointListsScreen({super.key});

  @override
  State<CheckPointListsScreen> createState() => _CheckPointListsScreenState();
}

class _CheckPointListsScreenState extends State<CheckPointListsScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(
          appbarTitle: 'Checkpoints',
        ),
        backgroundColor: white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
          child: ListView.builder(
            itemCount: checkpointData.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CheckpointsAlertDialog();
                      });
                },
                child: CheckPointListsWidget(
                  title: checkpointData[index].title,
                  imageUrl: checkpointData[index].imageUrl,
                  iscompleted: checkpointData[index].isCompleted,
                  checkpointNo: checkpointData[index].checkpointsNo,
                  date: checkpointData[index].date,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
