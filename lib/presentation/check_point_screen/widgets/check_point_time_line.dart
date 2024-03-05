import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:sgt/presentation/check_point_screen/model/checkpointpropertyWise_model.dart';
import 'package:sgt/utils/const.dart';

class CheckPointTimeLineWidget extends StatefulWidget {
  List<Checkpoint>? checkPointLength;
  CheckPointTimeLineWidget({super.key, this.checkPointLength});

  @override
  State<CheckPointTimeLineWidget> createState() =>
      _CheckPointTimeLineWidgetState();
}

class _CheckPointTimeLineWidgetState extends State<CheckPointTimeLineWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: SizedBox(
        width: 50,
        child: Column(
          children: [
            Text(
              'Start',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
            Container(
              height: 83 * widget.checkPointLength!.length.toDouble(),
              width: 30,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.checkPointLength!.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              index == 0
                                  ? Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 3),
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          color: white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: seconderyColor,
                                              offset: Offset(0, 0),
                                              blurRadius: 10,
                                              spreadRadius: 4,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: primaryColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Container(
                                        height: 8,
                                        width: 8,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                      ),
                                    )
                                  : Container(
                                      height: 8,
                                      width: 8,
                                      margin: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: seconderyColor,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                              index == widget.checkPointLength!.length - 1
                                  ? Container()
                                  : Container(
                                      height: 70,
                                      child: VerticalDivider(
                                        color: primaryColor,
                                        thickness: 2,
                                      ))
                            ],
                          ),
                        ),
                        Positioned(
                          right: 25.0,
                          top: 10,
                          child: Text(
                            'CP ${index+1}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
