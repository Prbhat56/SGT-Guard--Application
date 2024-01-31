import 'package:flutter/material.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'check_point_card_widget.dart';
import 'package:http/http.dart' as http;


class CurveDesignWidget extends StatefulWidget {
Property? property ;
String? propertyImageBaseUrl;
  CurveDesignWidget({super.key, this.property, this.propertyImageBaseUrl});

  @override
  State<CurveDesignWidget> createState() => _CurveDesignWidgetState();
}

class _CurveDesignWidgetState extends State<CurveDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Stack(
        children: [
          widget.property!.propertyAvatars != null ?
          Image.network(
            widget.propertyImageBaseUrl.toString()+'/'+widget.property!.propertyAvatars!.first.propertyAvatar.toString(),
            fit: BoxFit.cover,
          ):Image.asset('assets/sgt_logo.png'),

          // Image.network(
          //   widget.propertyImageBaseUrl.toString()+'/'+widget.property!.propertyAvatars!.first.propertyAvatar.toString(),
          //   // 'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
          //   fit: BoxFit.cover,
          // ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/curve.png'),
            )),
            height: 300,
          ),
          Positioned(
            top: 260,
            left: 16,
            right: 16,
            child: CheckPointCardsWidget(
              property:widget.property,
              propertyImageBaseUrl:widget.propertyImageBaseUrl,
            ),
          ),
        ],
      ),
    );
  }
}
