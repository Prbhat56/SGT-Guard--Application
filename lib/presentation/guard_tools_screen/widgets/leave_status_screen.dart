import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/guard_tools_screen/widgets/leave_pending_popup.dart';
import 'package:sgt/presentation/guard_tools_screen/widgets/leave_rejection_popup.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/const.dart';
import 'leave_data_model.dart';
import 'package:http/http.dart' as http;

class LeaveStatusScreen extends StatefulWidget {
  const LeaveStatusScreen({super.key});

  @override
  State<LeaveStatusScreen> createState() => _LeaveStatusScreenState();
}

class _LeaveStatusScreenState extends State<LeaveStatusScreen> {
  int current_page = 1;
  late int last_page = 0;
  List<LeaveDatum> leaveDatum = [];

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<bool> getLeaveList() async {
    EasyLoading.show();
    if (current_page < last_page) {
      refreshController.loadNoData();
      return true;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    String apiUrl = baseUrl + 'guard/leave-applications?page=$current_page';
    // print(apiUrl);

    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);

    if (response.statusCode == 200) {
      final LeaveListModel responseModel = leaveModelFromJson(response.body);
      //leaveDatum = responseModel.response!.data ?? [];
      leaveDatum.addAll(responseModel.response!.data!);

      current_page = responseModel.response!.currentPage ?? 0;

      current_page++;
      // print(current_page.toString());
      last_page = responseModel.response!.lastPage ?? 0;
      // print('Last page: ${last_page}');
      EasyLoading.dismiss();
      setState(() {});
      return true;
    } else {
      if (response.statusCode == 401) {
        print("--------------------------------Unauthorized");
        var apiService = ApiCallMethodsService();
        apiService.updateUserDetails('');
        var commonService = CommonService();
        FirebaseHelper.signOut();
        FirebaseHelper.auth = FirebaseAuth.instance;
        commonService.logDataClear();
        commonService.clearLocalStorage();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('welcome', '1');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false,
        );
        return false;
      } else {
        EasyLoading.dismiss();
      return false;
      }
      
    }
  }

  @override
  void initState() {
    super.initState();
    getLeaveList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Leave Status'),
        body: SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          enablePullDown: false,
          onLoading: () async {
            final result = await getLeaveList();
            if (result) {
              if (current_page <= last_page) {
                print("load Complete");
                refreshController.loadComplete();
              } else {
                print("load No Data");
                refreshController.loadNoData();
              }
            } else {
                print("load Failed");
              refreshController.loadFailed();
            }
          },
          child: ListView.builder(
              itemCount: leaveDatum.length,
              itemBuilder: (context, index) {
                final leave = leaveDatum[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          // CircleAvatar(
                          //   radius: 30,
                          //   backgroundImage: NetworkImage(
                          //     'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                          //   ),
                          // ),
                          CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage(leave.status == 'Rejected'
                                      ? 'assets/rejected_leave.png'
                                      : leave.status == 'Pending'
                                          ? 'assets/pending_leave.png'
                                          : leave.status == 'Approved'
                                              ? 'assets/approved_leave.png'
                                              : 'assets/pending_leave.png')),

                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    leave.subject.toString(),
                                    style: TextStyle(fontSize: 15),
                                    overflow: TextOverflow.ellipsis,
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
                                        '${DateFormat('MMM d, yyyy').format(DateTime.parse(leave.leaveFrom.toString()))} - ${DateFormat('MMM d, yyyy').format(DateTime.parse(leave.leaveTo.toString()))}',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  /*Container(
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
                                                  borderRadius: BorderRadius.circular(16),
                                                  border: Border.all(
                                                      color: leaveData[index].status ==
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
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            )*/
                                  GestureDetector(
                                    onTap: () {
                                      leave.status == "Rejected"
                                          ? showDialog(
                                              context: context,
                                              builder: (context) {
                                                return LeaveRejectInfo(
                                                  statusOfLeave:
                                                      leave.status.toString(),
                                                  name: leave.userFirstName
                                                          .toString() +
                                                      ' ' +
                                                      leave.userLastName.toString(),
                                                  date: leave.statusUpdateDate
                                                      .toString(),
                                                  time: leave.statusUpdateTime
                                                      .toString(),
                                                  reason:
                                                      leave.rejectOfReason == null
                                                          ? 'No Reason'
                                                          : leave.rejectOfReason
                                                              .toString(),
                                                );
                                              })
                                          : leave.status == "Approved"
                                              ? showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return LeaveRejectInfo(
                                                      statusOfLeave:
                                                          leave.status.toString(),
                                                      name: leave.userFirstName
                                                              .toString() +
                                                          ' ' +
                                                          leave.userLastName
                                                              .toString(),
                                                      date: leave.statusUpdateDate
                                                          .toString(),
                                                      time: leave.statusUpdateTime
                                                          .toString(),
                                                      reason: leave.subject == null
                                                          ? 'No Subject'
                                                          : leave.subject
                                                              .toString(),
                                                    );
                                                  })
                                              : showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return LeavePendingInfo(
                                                      leaveId:leave.id.toString(),
                                                      statusOfLeave:
                                                          leave.status.toString(),
                                                      reason: leave.subject == null
                                                          ? 'No Subject'
                                                          : leave.subject
                                                              .toString(),
                                                    );
                                                  });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 14),
                                      decoration: BoxDecoration(
                                          // color: leave.status.toString() == "1"
                                          //     ? primaryColor
                                          //     : leave.status.toString() == "0"
                                          //         ? white
                                          //         : Colors.transparent,
                                          color: leave.status.toString() ==
                                                  "Approved"
                                              ? primaryColor
                                              : leave.status.toString() == "Pending"
                                                  ? Colors.grey
                                                  : leave.status.toString() ==
                                                          "Rejected"
                                                      ? Colors.red
                                                      : Colors.transparent,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(
                                              color: leave.status.toString() ==
                                                      "Approved"
                                                  ? primaryColor
                                                  : Colors.transparent)),
                                      child: Text(
                                        leave.status.toString() == "Approved"
                                            ? "Approved"
                                            : leave.status.toString() == "Pending"
                                                ? "Pending"
                                                : "Rejected",
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 0,
                    )
                  ],
                );
              }),
        )
        /*FutureBuilder(
        future: getLeaveList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SmartRefresher(
              controller: refreshController,
              enablePullUp: true,
              enablePullDown: false,
              onLoading: () async {
                final result = await getLeaveList();
                if (result) {
                  refreshController.loadComplete();
                } else {
                  refreshController.loadFailed();
                }
              },
              child: ListView.builder(
                  itemCount: leaveDatum.length,
                  itemBuilder: (context, index) {
                    final leave = leaveDatum[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    leave.subject.toString(),
                                    style: TextStyle(fontSize: 15),
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
                                        '${DateFormat('MMM d, yyyy').format(DateTime.parse(leave.leaveFrom.toString()))}-${DateFormat('MMM d, yyyy').format(DateTime.parse(leave.leaveTo.toString()))}',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  /*Container(
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
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(
                                                  color: leaveData[index].status ==
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
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )*/
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 14),
                                    decoration: BoxDecoration(
                                        color: leave.status.toString() == "1"
                                            ? primaryColor
                                            : leave.status.toString() == "0"
                                                ? white
                                                : Colors.transparent,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color:
                                                leave.status.toString() == "0"
                                                    ? primaryColor
                                                    : Colors.transparent)),
                                    child: Text(
                                      leave.status.toString() == "1"
                                          ? "Approved"
                                          : "Waiting For Approval",
                                      style: TextStyle(
                                          color: leave.status.toString() == "0"
                                              ? primaryColor
                                              : white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
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
                    );
                  }),
            );
          }
        },
      ),*/
        );
  }
}
