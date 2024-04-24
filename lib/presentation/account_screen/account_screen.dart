import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/account_screen/model/guard_details_model.dart';
import 'package:sgt/presentation/settings_screen/settings_screen.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../widgets/custom_underline_textfield_widget.dart';
import 'package:http/http.dart' as http;

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Future<GuardDetails> getGuardDetailsAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };

    String apiUrl = baseUrl + apiRoutes['userDetails']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return GuardDetails.fromJson(data);
    } else {
      throw Exception('Failed to load guard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 48,
          shadowColor: Color.fromARGB(255, 186, 185, 185),
          elevation: 6,
          backgroundColor: white,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
            ),
            child: Icon(
              Icons.check_circle,
              color: greenColor,
            ),
          ),
          leadingWidth: 30,
          title: Text(
            'Account',
            style: TextStyle(
                color: CustomTheme.primaryColor, fontWeight: FontWeight.w700),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen()))
                    .then((value) => setState(() {}));
              },
              icon: Icon(
                Icons.settings_rounded,
                color: primaryColor,
              ),
            )
          ],
        ), //MainAppBarWidget(appBarTitle: 'Account'),
        backgroundColor: white,
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: FutureBuilder<GuardDetails>(
                    future: getGuardDetailsAPI(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
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
                                      imageUrl: (snapshot.data!.imageBaseUrl
                                              .toString() +
                                          '' +
                                          snapshot.data!.userDetails!.avatar
                                              .toString()),
                                      fit: BoxFit.fill,
                                      width: 140,
                                      height: 140,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(
                                            strokeCap: StrokeCap.round,
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                            'assets/sgt_logo.jpg',
                                            fit: BoxFit.fill,
                                          )),
                                ),
                                radius: 70,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: CustomTheme.grey.withOpacity(0.5),
                              thickness: 5,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Personal',
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                    color: black)),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomUnderlineTextFieldWidget(
                              bottomPadding: 7,
                              textfieldTitle: 'First Name',
                              hintText:
                                  (snapshot.data!.userDetails!.firstName == null
                                      ? ''
                                      : snapshot.data!.userDetails!.firstName
                                          .toString()),
                              readonly: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomUnderlineTextFieldWidget(
                              bottomPadding: 7,
                              textfieldTitle: 'Last Name',
                              hintText:
                                  (snapshot.data!.userDetails!.lastName == null
                                      ? ''
                                      : snapshot.data!.userDetails!.lastName
                                          .toString()),
                              // snapshot.data!.userDetails!.lastName.toString(),
                              readonly: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomUnderlineTextFieldWidget(
                              bottomPadding: 7,
                              textfieldTitle: 'Email',
                              hintText: snapshot.data!.userDetails!.emailAddress
                                  .toString(),
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
                              hintText: (snapshot
                                              .data!.userDetails!.contactCode ==
                                          null
                                      ? ''
                                      : "${snapshot.data!.userDetails!.contactCode.toString()}") +
                                  ' ' +
                                  (snapshot.data!.userDetails!.contactNumber ==
                                          null
                                      ? ''
                                      : snapshot
                                          .data!.userDetails!.contactNumber
                                          .toString()),
                              readonly: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomUnderlineTextFieldWidget(
                              bottomPadding: 7,
                              textfieldTitle: 'Gender',
                              hintText:
                                  (snapshot.data!.userDetails!.gender == null
                                      ? ''
                                      : snapshot.data!.userDetails!.gender
                                          .toString()),
                              readonly: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomUnderlineTextFieldWidget(
                              bottomPadding: 7,
                              textfieldTitle: 'Date Of Birth',
                              hintText:
                                  (snapshot.data!.userDetails!.dateOfBirth ==
                                          null
                                      ? ''
                                      : snapshot.data!.userDetails!.dateOfBirth!
                                          .toString()
                                          .substring(0, 10)),
                              readonly: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomUnderlineTextFieldWidget(
                              bottomPadding: 7,
                              textfieldTitle: 'Guard Position',
                              hintText: (snapshot
                                          .data!.userDetails!.guardPosition ==
                                      null
                                  ? ''
                                  : snapshot.data!.userDetails!.guardPosition
                                      .toString()
                                      .capitalized()),
                              readonly: true,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: CustomTheme.grey.withOpacity(0.5),
                              thickness: 5,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Address',
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w600,
                                  color: black),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomUnderlineTextFieldWidget(
                              bottomPadding: 7,
                              textfieldTitle: 'Street',
                              hintText:
                                  (snapshot.data!.userDetails!.street == null
                                      ? ''
                                      : snapshot.data!.userDetails!.street
                                          .toString()),
                              readonly: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomUnderlineTextFieldWidget(
                              bottomPadding: 7,
                              textfieldTitle: 'City',
                              hintText:
                                  (snapshot.data!.userDetails!.cityText == null
                                      ? ''
                                      : snapshot.data!.userDetails!.cityText
                                          .toString()),
                              readonly: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomUnderlineTextFieldWidget(
                              bottomPadding: 7,
                              textfieldTitle: 'State',
                              hintText:
                                  (snapshot.data!.userDetails!.stateText == null
                                      ? ''
                                      : snapshot.data!.userDetails!.stateText
                                          .toString()),
                              readonly: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomUnderlineTextFieldWidget(
                              bottomPadding: 7,
                              textfieldTitle: 'Country',
                              hintText:
                                  (snapshot.data!.userDetails!.countryText ==
                                          null
                                      ? ''
                                      : snapshot.data!.userDetails!.countryText
                                          .toString()),
                              readonly: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomUnderlineTextFieldWidget(
                              bottomPadding: 7,
                              textfieldTitle: 'Zipcode',
                              hintText:
                                  snapshot.data!.userDetails!.zipCode == null
                                      ? ''
                                      : snapshot.data!.userDetails!.zipCode
                                          .toString(),
                              readonly: true,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Divider(
                            //   color: CustomTheme.grey.withOpacity(0.5),
                            //   thickness: 5,
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            // Text(
                            //   'Guard Cards',
                            //   style: CustomTheme.blackTextStyle(21),
                            // ),
                            const SizedBox(
                              height: 16,
                            ),
                            //GuardCard(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Guard ID card',
                                    style: TextStyle(
                                      fontSize: 21,
                                      color: CustomTheme.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textScaleFactor: 1.0,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 180,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: snapshot.data!.userDetails!
                                                    .frontSideIdCard !=
                                                null
                                            ? CachedNetworkImage(
                                                imageUrl: (snapshot
                                                        .data!.imageBaseUrl
                                                        .toString() +
                                                    '' +
                                                    snapshot.data!.userDetails!
                                                        .frontSideIdCard
                                                        .toString()),
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            const CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                          'assets/sgt_logo.jpg',
                                                          fit: BoxFit.fill,
                                                        ))
                                            : Image.asset(
                                                'assets/sgt_logo.jpg',
                                                fit: BoxFit.fill,
                                              )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    color: CustomTheme.grey.withOpacity(0.5),
                                    thickness: 5,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Weapon Permit',
                                    style: TextStyle(
                                      fontSize: 21,
                                      color: CustomTheme.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textScaleFactor: 1.0,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    height: 180,
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: snapshot.data!.userDetails!
                                                    .backSideIdCard !=
                                                null
                                            ? CachedNetworkImage(
                                                imageUrl: snapshot
                                                        .data!.imageBaseUrl
                                                        .toString() +
                                                    '' +
                                                    snapshot.data!.userDetails!
                                                        .backSideIdCard
                                                        .toString(),
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                          const CircularProgressIndicator(
                                                        strokeCap:
                                                            StrokeCap.round,
                                                      ),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                          'assets/sgt_logo.jpg',
                                                          fit: BoxFit.fill,
                                                        ))
                                            : Image.asset(
                                                'assets/sgt_logo.jpg',
                                                fit: BoxFit.fill,
                                              )),
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
                    })),
          ),
        ));
  }
}
