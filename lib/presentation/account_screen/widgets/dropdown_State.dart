import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgt/presentation/account_screen/model/country_model.dart';
import 'package:sgt/presentation/account_screen/model/state_model.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/service/globals.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class dropdownState extends StatefulWidget {
  @override
  State<dropdownState> createState() => _dropdownstateState();
}

Future<StateModel> getStateList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, String> myHeader = <String, String>{
    "Authorization": "Bearer ${prefs.getString('token')}",
  };
  print(myHeader);

  String apiUrl = baseUrl + apiRoutes['state']!;
  var map = new Map<String, dynamic>(); 
  map['country_id'] = '101';
  final response = await http.post(Uri.parse(apiUrl),body: map ,headers: myHeader);

  var data = jsonDecode(response.body.toString());

  if (response.statusCode == 200) {
    print(data['states']);
    return StateModel(states: data['states']);
  } else {
    return StateModel(states: data['states']);
  }
}

class _dropdownstateState extends State<dropdownState> {
  double bottomPadding = 25;

  @override
  Widget build(BuildContext context) {
    var userD = jsonDecode(userDetail);
    return Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: FutureBuilder<StateModel>(
            future: getStateList(),
            builder: (context,AsyncSnapshot<StateModel> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                print(snapshot.data);
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.states!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "State",
                            // snapshot.data!.states![index].name.toString(),
                            style: CustomTheme.textField_Headertext_Style,
                            textScaleFactor: 1.0,
                          ),
                          DropdownButtonFormField<String>(
                            value: userD['user_details']['state_text'],
                            onChanged: (String? newValue) {
                              // getCountry();
                              setState(() {
                                // selectedCity = newValue!;
                              });
                            },
                            items: <String>[snapshot.data!.states.toString()]
                                .map<DropdownMenuItem<String>>((String value) {
                                  // print("value ==> $value");
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
            }
          )
      );
  }
}
