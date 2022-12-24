import 'package:flutter/material.dart';
import 'package:sgt/presentation/shift_details_screen/shift_details_sceen.dart';
import '../../../utils/const.dart';

class ShiftCards extends StatelessWidget {
  const ShiftCards(
      {super.key, required this.shiftdate, required this.shifttime});
  final String shiftdate;
  final String shifttime;
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: InkWell(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => ShiftDetailsScreen()));
        },
        child: Container(
          height: 48,
          width: 122,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                shiftdate,
                style: TextStyle(color: white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                shifttime,
                style: TextStyle(color: white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
