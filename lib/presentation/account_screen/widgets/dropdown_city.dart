import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgt/presentation/account_screen/model/city_model.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/service/globals.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class dropDownCity extends StatefulWidget {
  @override
  State<dropDownCity> createState() => _dropDownCityState();
}

Future<CityModel> getCityList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, String> myHeader = <String, String>{
    "Authorization": "Bearer ${prefs.getString('token')}",
  };

  String apiUrl = baseUrl + apiRoutes['city']!;
  var map = new Map<String, dynamic>(); 
  map['state_id'] = '33';
  final response = await http.post(Uri.parse(apiUrl),body: map, headers: myHeader);

  var data = jsonDecode(response.body.toString());

  if (response.statusCode == 200) {
    return CityModel(cities: data);
  } else {
    return CityModel(cities: data);
  }
}

class _dropDownCityState extends State<dropDownCity> {
  double bottomPadding = 25;

  @override
  Widget build(BuildContext context) {
    var userD = jsonDecode(userDetail);
    return Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: FutureBuilder<CityModel>(
            future: getCityList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    // itemCount: dummyData.length,
                    itemCount: snapshot.data!.cities!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "City",
                            style: CustomTheme.textField_Headertext_Style,
                            textScaleFactor: 1.0,
                          ),
                          DropdownButtonFormField<String>(
                            value: userD['user_details']['city'],
                            onChanged: (String? newValue) {
                              // setState(() {
                              //   selectedCity = newValue!;
                              // });
                            },
                           items: <String>[snapshot.data!.cities.toString()]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        ],
                      );
                    });
              }
            }));
  }
}
