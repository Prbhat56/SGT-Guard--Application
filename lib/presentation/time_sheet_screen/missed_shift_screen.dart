import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/time_sheet_screen/widget/missed_shift_details.dart';
import 'package:sgt/presentation/time_sheet_screen/widget/time_sheet_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import '../../utils/const.dart';

class MissedShiftScreen extends StatelessWidget {
  const MissedShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Missed Shifts'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dummytimeSheetData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              screenNavigator(
                                  context, MissedShiftDetailsScreen());
                            },
                            contentPadding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 0),
                            dense: false,
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: grey,
                              backgroundImage: NetworkImage(
                                dummytimeSheetData[index].imageUrl,
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  dummytimeSheetData[index].title,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  dummytimeSheetData[index].date,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(dummytimeSheetData[index].time),
                            ),
                            trailing: Column(
                              children: [
                                Text(dummytimeSheetData[index].shiftTime),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 20,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      'Missed',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 80),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
