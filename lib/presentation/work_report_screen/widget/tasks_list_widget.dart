import 'package:flutter/material.dart';
import 'package:sgt/presentation/work_report_screen/model/checkPoint_model.dart';
import 'package:sgt/utils/const.dart';

class TasksListWidget extends StatefulWidget {
  // final ValueChanged<String> checkPointIdList;
  List<CheckPointTask>? checkPointTask;
  TasksListWidget({super.key, this.checkPointTask,
  // required this.checkPointIdList
  });

  @override
  State<TasksListWidget> createState() => _TasksListWidgetState();
}

class _TasksListWidgetState extends State<TasksListWidget> {
  List<CheckPointTask> checkpoints = [];
  List<bool> checkpointsStatus = [];
  List<bool> checkbox = [
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
      height: 50 * widget.checkPointTask!.length.toDouble(),
      child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: widget.checkPointTask!.length,
          itemBuilder: (context, index) {
            return Container(
                child: CheckboxListTile(
              title: Text(
                widget.checkPointTask![index].checkpointTasks.toString(),
                style: TextStyle(fontSize: 13),
              ),
              value: checkbox[index],
              // value: widget.checkPointTask![index].status == 1 ? true : false,
              onChanged: (value) {
                setState(
                  () {
                    checkbox[index] = value!;
                    print("value =======================> ${value}");
                  },
                );
                if (checkpointsStatus
                    .contains(widget.checkPointTask![index].status == 1)) {
                  checkpointsStatus
                      .remove(widget.checkPointTask![index]); // unselect
                } else {
                  checkpointsStatus
                      .add(widget.checkPointTask![index].status == 0); // select
                }
              },
              controlAffinity: ListTileControlAffinity.platform,
            ));
          }),
    );
  }
}
