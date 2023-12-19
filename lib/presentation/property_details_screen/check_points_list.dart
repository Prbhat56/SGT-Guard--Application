import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/check_point_screen/widgets/check_point_model.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/property_details_screen/model/checkPointsList_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import 'widgets/check_points_lists_widget.dart';
import 'widgets/checkpoints_alert_dialog.dart';
import 'package:http/http.dart' as http;

class CheckPointListsScreen extends StatefulWidget {
  List<CheckPoint>? checkPoint;
  String? imageBaseUrl;
  int? propertyId;
  CheckPointListsScreen(
      {super.key,
      required this.checkPoint,
      this.imageBaseUrl,
      this.propertyId});

  @override
  State<CheckPointListsScreen> createState() => _CheckPointListsScreenState();
}

Future<CheckPointsModal> getCheckpointsList(property_id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, String> myHeader = <String, String>{
    "Authorization": "Bearer ${prefs.getString('token')}",
  };
  Map<String, dynamic> myJsonBody = {'property_id': property_id.toString()};
  String apiUrl = baseUrl + apiRoutes['checkpointListPropertyWise']!;
  final response = await http.post(Uri.parse(apiUrl), headers: myHeader,body: myJsonBody);
  print(response.body.toString());
  var data = jsonDecode(response.body.toString());
  print(data);
  if (response.statusCode == 201) {
    final CheckPointsModal responseModel =
        checkPointsModalFromJson(response.body);
    return responseModel;
  } else {
    return CheckPointsModal(
      status: response.statusCode,
      // imageBaseUrl: ''
    );
  }
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
          body: FutureBuilder(
              future: getCheckpointsList(widget.propertyId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Container(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator()));
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
                    child: ListView.builder(
                      // itemCount: widget.checkPoint!.length,
                      itemCount: snapshot.data!.checkpoints!.length,
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
                            title: snapshot.data!.checkpoints![index].checkpointName
                                .toString(),
                            imageUrl: snapshot.data!.imageBaseUrl.toString() +
                                '/' +
                                snapshot.data!.checkpoints![index].checkpointQrCode
                                    .toString(),
                            // iscompleted: snapshot.data!.checkpoints![index].isCompleted,
                            checkpointNo:
                                snapshot.data!.checkpoints![index].id ?? 0,
                            date: snapshot.data!.checkpoints![index].createdAt!
                                .toLocal()
                                .toString(),
                          ),
                        );
                      },
                    ),
                  );
                }
              })),
    );
  }
}
