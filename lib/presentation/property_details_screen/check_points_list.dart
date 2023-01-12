import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/time_sheet_screen/widgets/check_point_model.dart';
import '../../utils/const.dart';
import 'widgets/check_points_lists_widget.dart';

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          title: Text('Checkpoints List',
              style: TextStyle(color: black), textScaleFactor: 1.0),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: black)),
        ),
        backgroundColor: white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView.builder(
            itemCount: checkpointData.length,
            itemBuilder: (context, index) {
              return CheckPointListsWidget(
                title: checkpointData[index].title,
                imageUrl: checkpointData[index].imageUrl,
                iscompleted: checkpointData[index].isCompleted,
              );
            },
          ),
        ),
      ),
    );
  }
}
