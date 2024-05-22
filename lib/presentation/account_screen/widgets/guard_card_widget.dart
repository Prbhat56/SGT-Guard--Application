import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgt/service/globals.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';

class GuardCard extends StatelessWidget {
  const GuardCard({super.key});


  @override
  Widget build(BuildContext context) {
    var userD = jsonDecode(userDetail);
    return Container(
      // height: 196,
      // decoration: BoxDecoration(
      //     color: primaryColor, borderRadius: BorderRadius.circular(10)),
        // child: Image.network(userD['image_base_url']+'/'+userD['user_details']['front_side_id_card'],),
        // child: Image.network(userD['image_base_url']+'/'+userD['user_details']['back_side_id_card'],),
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Container(
            height: 25,
            color: black,
            alignment: Alignment.center,
            child: Image.asset('assets/sgt_logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    userD['image_base_url']+'/'+userD['user_details']['front_side_id_card'],
                    // 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    height: 68,
                    width: 68,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error,color: Colors.red);
                    },
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/ac_qr.png',
                      height: 56,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      userD['user_details']['contact_code'].toString()+" "+userD['user_details']['contact_number'].toString(),
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'name'.tr+' :',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userD['user_details']['first_name'].toString()+" "+userD['user_details']['last_name'].toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w300),
                    ),
                    Container(
                      width: 254,
                      child: Divider(
                        color: white,
                        height: 3,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gaurd ID :',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userD['user_details']['guard_user_id'].toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w300),
                    ),
                    Container(
                      width: 244,
                      child: Divider(
                        color: white,
                        height: 3,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Card Expiry Date :',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '27 January 2024',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w300),
                    ),
                    Container(
                      width: 216,
                      child: Divider(
                        color: white,
                        height: 3,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
