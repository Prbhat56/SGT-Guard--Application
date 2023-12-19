import 'package:flutter/material.dart';
import 'package:sgt/presentation/work_report_screen/model/checkPoint_model.dart';
import 'package:sgt/utils/const.dart';

class TasksListWidget extends StatefulWidget {
  List<CheckPointTask>? checkPointTask ;
  TasksListWidget({super.key,this.checkPointTask});

  @override
  State<TasksListWidget> createState() => _TasksListWidgetState();
}

class _TasksListWidgetState extends State<TasksListWidget> {
  List<String> tasksData = [
    "Met with manager",
    "Checked server room",
    "Checked server room",
    "Take a tour of parking",
    "Check car number 5298",
    "Create a general report",
    "Check all security cameras",
    "Create parking report",
    "Take a tour of server room",
  ];
  List<bool> checkbox = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 30 * tasksData.length.toDouble(),
      height: 30 * widget.checkPointTask!.length.toDouble(),
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.checkPointTask!.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 11),
              height: 18,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.checkPointTask![index].checkpointTasks.toString(),
                    style: TextStyle(fontSize: 13),
                  ),
                  Checkbox(
                    activeColor: primaryColor,
                    side: BorderSide(color: primaryColor),
                    onChanged: (v) {
                      setState(
                        () {
                          checkbox[index] = v!;
                        },
                      );
                      print(v);
                    },
                    value: checkbox[index],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
