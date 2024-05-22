import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/property_details_screen/model/checkPointsList_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import 'widgets/check_points_lists_widget.dart';
import 'widgets/checkpoints_alert_dialog.dart';
import 'package:http/http.dart' as http;

class CheckPointListsScreen extends StatefulWidget {
  String? imageBaseUrl;
  int? propertyId;
  CheckPointListsScreen({super.key, this.imageBaseUrl, this.propertyId});

  @override
  State<CheckPointListsScreen> createState() => _CheckPointListsScreenState();
}
List<Checkpoint> checkpoint = [];
// var getCheckpointDataFetched;
String? imageBaseUrlData;
String? propertyImageBaseUrlData;
class _CheckPointListsScreenState extends State<CheckPointListsScreen> {

 @override
  void initState() {
    super.initState();
  //  getCheckpointDataFetched = getCheckpointsList(widget.propertyId);
  }



  Future getCheckpointsList(property_id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // String? property_id = prefs.getString('propertyId');
  Map<String, String> myHeader = <String, String>{
    "Authorization": "Bearer ${prefs.getString('token')}",
  };
  Map<String, dynamic> myJsonBody = {'property_id': property_id.toString()};
  String apiUrl = baseUrl + apiRoutes['checkpointListPropertyWise']!;
  final response =
      await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
  if (response.statusCode == 201) {
    final CheckpointsOnProperty responseModel =
        checkpointsOnPropertyFromJson(response.body);
        checkpoint = responseModel.checkpoints ?? [];
        imageBaseUrlData = responseModel.imageBaseUrl;
        propertyImageBaseUrlData = responseModel.propertyImageBaseUrl;
    return responseModel;
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
      } else {
        return CheckpointsOnProperty(
      status: response.statusCode,
      // imageBaseUrl: ''
    );
      }
    
  }
}
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          appBar: CustomAppBarWidget(
            appbarTitle: 'checkpoint'.tr,
          ),
          backgroundColor: white,
          body: FutureBuilder(
              future: getCheckpointsList(widget.propertyId),
              builder: (context, snapshot) {
                // if (!snapshot.hasData) {
                //   return Center(
                //       child: Container(
                //           height: 60,
                //           width: 60,
                //           child: CircularProgressIndicator()));
                // } else {
                  return checkpoint.isEmpty
                      ? SizedBox(
                          child: Center(
                            child: Text(
                              'No CheckPoints Available',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10),
                          child: ListView.builder(
                            // itemCount: widget.checkPoint!.length,
                            itemCount: checkpoint.length,
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
                                  title: checkpoint[index].checkpointName.toString(),
                                  imageBaseUrl: imageBaseUrlData.toString(),
                                  imageUrl:checkpoint[index].checkPointAvatar!.isEmpty ?'' :checkpoint[index].checkPointAvatar![0].checkpointAvatars.toString(),
                                  // iscompleted: snapshot.data!.checkpoints![index].isCompleted,
                                  checkpointNo:checkpoint[index].id ?? 0,
                                  date: checkpoint[index].checkInTime.toString(),
                                  time:checkpoint[index].checkInDate.toString(),
                                ),
                              );
                            },
                          ),
                        );
                // }
              })),
    );
  }
}
