import 'package:flutter/material.dart';
import 'package:sgt/presentation/time_sheet_screen/widgets/time_sheet_model.dart';
import '../../../utils/const.dart';
import '../../shift_details_screen/shift_details_sceen.dart';

class UpcomingWidgetTab extends StatelessWidget {
  const UpcomingWidgetTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dummytimeSheetData.length,
        itemBuilder: (context, index) {
          return Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ShiftDetailsScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(1, 0), end: Offset.zero)
                              .animate(animation),
                          child: child,
                        );
                      },
                    ),
                  );
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const ShiftDetailsScreen()));
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
                          color: dummytimeSheetData[index].isCompleted
                              ? greenColor
                              : const Color.fromARGB(255, 109, 109, 109),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          dummytimeSheetData[index].isCompleted
                              ? 'Completed'
                              : 'Cenceled',
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
        });
  }
}
