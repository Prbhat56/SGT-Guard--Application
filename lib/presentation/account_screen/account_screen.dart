import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/account_screen/model/guard_details_model.dart';
import 'package:sgt/presentation/clocked_in_out_screen/clock_in_screen.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/service/globals.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../widgets/custom_underline_textfield_widget.dart';
import '../widgets/main_appbar_widget.dart';
import 'package:http/http.dart' as http;


// String stringResponse;
late Map mapResponse;
// Map dataResponse;
// List listResponse;
late List listResponse;

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  void initState() {
    super.initState();
    // getPropertyGuardListAPI();
    setState(() {
      
    });
 }


Future<dynamic> getPropertyGuardListAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    // print(myHeader);

    String apiUrl = baseUrl + apiRoutes['userDetails']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return data;
    } else {
      setState(() {
        return data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(appBarTitle: 'Account'),
      backgroundColor: white,
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FutureBuilder<dynamic>(
              future: getPropertyGuardListAPI(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: CachedNetworkImage(
                          // imageUrl:(snapshot.data!.imageBaseUrl.toString()+'/'+snapshot.data!.userDetails!.avatar.toString())
                          imageUrl:(snapshot.data['image_base_url'].toString()+'/'+snapshot.data['user_details']['avatar'].toString())
                          // imageUrl: userD['image_base_url'] +
                          //     '/' +
                          //     userD['user_details']['avatar']
                              ,
                          fit: BoxFit.fill,
                          width: 140,
                          height: 140,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                                strokeCap: StrokeCap.round,
                              ),
                          errorWidget: (context, url, error) => Image.asset(
                                'assets/sgt_logo.jpg',
                                fit: BoxFit.fill,
                              )),
                    ),
                    radius: 70,
                    backgroundColor: grey,
                  ),
                ),
                Text(
                  'Personal',
                  style: CustomTheme.blackTextStyle(21),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'First Name',
                  hintText: (snapshot.data['user_details']['first_name']==null ? '': snapshot.data['user_details']['first_name'].toString()),
                  // snapshot.data!.userDetails!.firstName.toString(),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'Last Name',
                  hintText:(snapshot.data['user_details']['last_name']==null ? '':snapshot.data['user_details']['last_name'].toString()),
                  // snapshot.data!.userDetails!.lastName.toString(),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'Email',
                  hintText: snapshot.data['user_details']['email_address'].toString(),
                  // snapshot.data!.userDetails!.emailAddress.toString(),
                  readonly: true,
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // CustomUnderlineTextFieldWidget(
                //   bottomPadding: 7,
                //   textfieldTitle: 'Phone code',
                //   hintText: (userD['user_details']['contact_code'] !=null ? userD['user_details']['contact_code'].toString():''),
                //   readonly: true,
                // ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'Phone',
                  hintText: (snapshot.data['user_details']['contact_code']==null ? '' : snapshot.data['user_details']['contact_code'].toString()) +
                      ' ' +
                      (snapshot.data['user_details']['contact_number']==null ? '': snapshot.data['user_details']['contact_number'].toString()),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'Gender',
                  hintText: (snapshot.data['user_details']['gender']==null ? '':snapshot.data['user_details']['gender'].toString()),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'Date Of Birth',
                  hintText: (snapshot.data['user_details']['date_of_birth']==null ? '':snapshot.data['user_details']['date_of_birth'].toString()),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'Guard Position',
                  hintText: (snapshot.data['user_details']['guard_position']==null ? '':snapshot.data['user_details']['guard_position'].toString()),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Address',
                  style: CustomTheme.blackTextStyle(21),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'Street',
                  hintText: (snapshot.data['user_details']['street']==null ? '':snapshot.data['user_details']['street'].toString()),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'City',
                  hintText: (snapshot.data['user_details']['city_text']==null ? '':snapshot.data['user_details']['city_text'].toString()),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'State',
                  hintText: (snapshot.data['user_details']['state_text']==null ? '':snapshot.data['user_details']['state_text'].toString()),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'Country',
                  hintText: (snapshot.data['user_details']['country_text']==null ? '':snapshot.data['user_details']['country_text'].toString()),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'Zipcode',
                  hintText: snapshot.data['user_details']['zip_code']==null ? '':snapshot.data['user_details']['zip_code'].toString(),
                  readonly: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Guard Cards',
                  style: CustomTheme.blackTextStyle(21),
                ),
                const SizedBox(
                  height: 16,
                ),
                //GuardCard(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child:
                      Text(
                      'Front Side Id Card',
                      style: CustomTheme.textField_Headertext_Style,
                      textScaleFactor: 1.0,
                      ),
                       ),
                      Container(
                        height: 180,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: snapshot.data['user_details']['front_side_id_card']!=null ?CachedNetworkImage(
                                  imageUrl: (snapshot.data['image_base_url'].toString() +
                                      '/' +
                                      snapshot.data['user_details']['front_side_id_card'].toString()),
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Center(
                                      child: const CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        'assets/sgt_logo.jpg',
                                        fit: BoxFit.fill,
                                      )) : Image.asset(
                                        'assets/sgt_logo.jpg',
                                        fit: BoxFit.fill,
                                      )
                              ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                       Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child:
                      Text(
                      'Back Side Id Card',
                      style: CustomTheme.textField_Headertext_Style,
                      textScaleFactor: 1.0,
                      ),
                       ),
                      Container(
                        height: 180,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: snapshot.data['user_details']['back_side_id_card']!=null ?
                          CachedNetworkImage(
                                  imageUrl: snapshot.data['image_base_url'].toString() +
                                      '/' +
                                      snapshot.data['user_details']['back_side_id_card'].toString(),
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) =>
                                      Center(
                                        child: const CircularProgressIndicator(
                                          strokeCap: StrokeCap.round,
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        'assets/sgt_logo.jpg',
                                        fit: BoxFit.fill,
                                      )) : Image.asset(
                                        'assets/sgt_logo.jpg',
                                        fit: BoxFit.fill,
                                      )
                              ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            );
          }
        }
        )
      ),
    ),
  )
    );
  }
}