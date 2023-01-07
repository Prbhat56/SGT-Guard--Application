import 'package:flutter/material.dart';

import '../../../utils/const.dart';
import 'leave_data_model.dart';

class LeaveStatusScreen extends StatefulWidget {
  const LeaveStatusScreen({super.key});

  @override
  State<LeaveStatusScreen> createState() => _LeaveStatusScreenState();
}

class _LeaveStatusScreenState extends State<LeaveStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          backgroundColor: white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text('Leave Status',
              style: TextStyle(fontWeight: FontWeight.w400, color: black)),
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                // color: Colors.amber,
                height: 90 * leaveData.length.toDouble(),
                child: ListView.builder(
                    itemCount: leaveData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          //  Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => const PropertyDetailsScreen()))
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        NetworkImage(leaveData[index].imageUrl),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          'Subject',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            color: primaryColor,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            leaveData[index].date,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 14),
                                        decoration: BoxDecoration(
                                            color: leaveData[index].status ==
                                                    "Approved"
                                                ? primaryColor
                                                : leaveData[index].status ==
                                                        "Waiting For Approval"
                                                    ? white
                                                    : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                                color: leaveData[index]
                                                            .status ==
                                                        "Waiting For Approval"
                                                    ? primaryColor
                                                    : Colors.transparent)),
                                        child: Text(
                                          leaveData[index].status,
                                          style: TextStyle(
                                              color: leaveData[index].status ==
                                                      "Waiting For Approval"
                                                  ? primaryColor
                                                  : white,
                                              fontSize: 8),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              height: 0,
                            )
                          ],
                        ),
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
