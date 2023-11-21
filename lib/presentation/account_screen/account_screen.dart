import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/service/globals.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../utils/const.dart';
import '../widgets/custom_underline_textfield_widget.dart';
import '../widgets/main_appbar_widget.dart';
import 'widgets/guard_card_widget.dart';

// String stringResponse;
late Map mapResponse;
// Map dataResponse;
// List listResponse;
late List listResponse;

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userD = jsonDecode(userDetail);
    return Scaffold(
      appBar: MainAppBarWidget(appBarTitle: 'Account'),
      backgroundColor: white,
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: grey,
                    backgroundImage:  NetworkImage(
                      userD['image_base_url']+'/'+userD['user_details']['avatar'],
                    ),
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
                  hintText: (userD['user_details']['first_name'] !=null ? userD['user_details']['first_name'].toString() : ''),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'Last Name',
                  hintText: (userD['user_details']['last_name'] !=null ? userD['user_details']['last_name'].toString() : ''),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'Email',
                  hintText: userD['user_details']['email_address'].toString(),
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
                  hintText: (userD['user_details']['contact_code'] !=null ? userD['user_details']['contact_code'].toString():'')+' '+(userD['user_details']['contact_number'] !=null ? userD['user_details']['contact_number'].toString():''),
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
                  hintText: (userD['user_details']['street'] !=null ? userD['user_details']['street'].toString():''),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'City',
                  hintText: (userD['user_details']['city'] !=null ? userD['user_details']['city'].toString():''),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'State',
                  hintText: (userD['user_details']['state'] !=null ? userD['user_details']['state'].toString():''),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'Country',
                  hintText: (userD['user_details']['country'] !=null ? userD['user_details']['country'].toString():''),
                  readonly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomUnderlineTextFieldWidget(
                  bottomPadding: 7,
                  textfieldTitle: 'Zipcode',
                  hintText: (userD['user_details']['zip_code'] !=null ? userD['user_details']['zip_code'].toString():''),
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
                GuardCard(),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
