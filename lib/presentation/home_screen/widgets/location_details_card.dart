import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/home_screen/model/GuardHome.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/const.dart';
import '../../property_details_screen/property_details_screen.dart';
import 'location_details_model.dart';
import 'package:http/http.dart' as http;


class LocationDetailsCard extends StatefulWidget {
  const LocationDetailsCard({super.key});

  @override
  State<LocationDetailsCard> createState() => _LocationDetailsCardState();
}

class _LocationDetailsCardState extends State<LocationDetailsCard> {

  Future<GuardHome> getPropertyGuardListAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    print(myHeader);

    String apiUrl = baseUrl + apiRoutes['homePage']!;
    final response = await http.post(Uri.parse(apiUrl), headers: myHeader);

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 201) {
      return GuardHome.fromJson(data);
    } else {
      return GuardHome.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: InkWell(
        onTap: () {
          screenNavigator(context, PropertyDetailsScreen());
        },
        child:FutureBuilder<GuardHome>(
              future: getPropertyGuardListAPI(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return Container(
                        // height: 290 * locationData.length.toDouble(),
                        height: 290 * snapshot.data!.jobs!.data!.length.toDouble(),
                        child: ListView.builder(
                            itemCount: snapshot.data!.jobs!.data!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 204,
                                      decoration: CustomTheme.locationCardStyle(
                                        snapshot.data!.propertyImageBaseUrl.toString(),
                                        snapshot.data!.jobs!.data![index].propertyAvatars![0].propertyAvatar.toString()),
                                          // (locationData[index].imageUrl),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data!.jobs!.data![index].propertyName.toString(),
                                          // locationData[index].title,
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        Text(
                                          locationData[index].duty,
                                          style: TextStyle(fontSize: 17, color: primaryColor),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: primaryColor,
                                          size: 15,
                                        ),
                                        Text(
                                          snapshot.data!.jobs!.data![index].propertyName.toString(),
                                          // locationData[index].subtitle,
                                          style: TextStyle(fontSize: 13, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        // locationData[index].address,
                                        snapshot.data!.jobs!.data![index].location.toString(),
                                        style: TextStyle(fontSize: 13, color: black),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      );
                }
              }
      ),
    ),
    );
  }
}
