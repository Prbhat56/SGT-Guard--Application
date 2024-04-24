import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_text_widget.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';

class FilterReportWidget extends StatefulWidget {
  final void Function(int, int, String, String, String) onData;
  const FilterReportWidget({super.key, required this.onData});

  @override
  State<FilterReportWidget> createState() => _FilterReportWidgetState();
}

bool _byProperty = false;
bool _dateRange = false;
TextEditingController fromdateinput = TextEditingController();
TextEditingController todateinput = TextEditingController();
bool _isGeneral = false;
bool _isMaintenance = false;
bool _isParking = false;
bool _isEmergency = false;

int? _propView;
int? _dateRangeValue;
String? _from;
String? _to;
List<String> _type = [];

class _FilterReportWidgetState extends State<FilterReportWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFieldHeaderWidget(title: 'Filters'),
            ListTileTheme(
              horizontalTitleGap: 0,
              child: CheckboxListTile(
                //contentPadding: EdgeInsets.only(top: 20),
                activeColor: primaryColor,
                selectedTileColor: primaryColor,
                side: BorderSide(color: primaryColor, width: 1.5),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
                title: Text(
                  'By Property View',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500, color: black),
                ),
                value: _byProperty,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _byProperty = value!;
                    value == true ? _propView = 1 : _propView = 0;
                  });
                },
              ),
            ),
            ListTileTheme(
              horizontalTitleGap: 0,
              child: CheckboxListTile(
                //contentPadding: EdgeInsets.only(top: 20),
                activeColor: primaryColor,
                selectedTileColor: primaryColor,
                side: BorderSide(color: primaryColor, width: 1.5),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
                title: Text(
                  'Date Range',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500, color: black),
                ),
                value: _dateRange,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _dateRange = value!;
                    value == true ? _dateRangeValue = 1 : _dateRangeValue = 0;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'From',
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            textScaleFactor: 1.0,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: fromdateinput,
                            clipBehavior: Clip.antiAlias,
                            decoration: InputDecoration(
                                hintText: 'yyyy-mm-dd',
                                hintStyle:
                                    TextStyle(color: CustomTheme.primaryColor),
                                focusColor: CustomTheme.primaryColor,
                                fillColor: seconderyColor,
                                filled: true,
                                //isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(10, 15, 5, 5),
                                suffixIcon: Icon(Icons.keyboard_arrow_down)),
                            readOnly: true,
                            //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(3000));
      
                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate);
      
                                setState(() {
                                  fromdateinput.text = formattedDate;
                                  _from = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'To',
                            style: TextStyle(
                              fontSize: 17,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            textScaleFactor: 1.0,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: todateinput,
                            clipBehavior: Clip.antiAlias,
                            decoration: InputDecoration(
                                hintText: 'yyyy-mm-dd',
                                hintStyle:
                                    TextStyle(color: CustomTheme.primaryColor),
                                focusColor: CustomTheme.primaryColor,
                                fillColor: seconderyColor,
                                filled: true,
                                //isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                contentPadding: EdgeInsets.fromLTRB(10, 15, 5, 5),
                                suffixIcon: Icon(Icons.keyboard_arrow_down)),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(3000));
      
                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate);
      
                                setState(() {
                                  todateinput.text = formattedDate;
                                  _to = formattedDate;
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTileTheme(
              horizontalTitleGap: 0,
              child: CheckboxListTile(
                //contentPadding: EdgeInsets.only(top: 20),
                activeColor: primaryColor,
                selectedTileColor: primaryColor,
                side: BorderSide(color: primaryColor, width: 1.5),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
                title: Text(
                  'General Report',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500, color: black),
                ),
                value: _isGeneral,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _isGeneral = value!;
                    if (_type.contains('General')) {
                      _type.remove('General');
                    } else {
                      _type.add('General');
                    }
                  });
                },
              ),
            ),
            ListTileTheme(
              horizontalTitleGap: 0,
              child: CheckboxListTile(
                //contentPadding: EdgeInsets.only(top: 20),
                activeColor: primaryColor,
                selectedTileColor: primaryColor,
                side: BorderSide(color: primaryColor, width: 1.5),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
                title: Text(
                  'Maintenance Report',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500, color: black),
                ),
                value: _isMaintenance,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _isMaintenance = value!;
                    if (_type.contains('Maintenance')) {
                      _type.remove('Maintenance');
                    } else {
                      _type.add('Maintenance');
                    }
                  });
                },
              ),
            ),
            ListTileTheme(
              horizontalTitleGap: 0,
              child: CheckboxListTile(
                //contentPadding: EdgeInsets.only(top: 20),
                activeColor: primaryColor,
                selectedTileColor: primaryColor,
                side: BorderSide(color: primaryColor, width: 1.5),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
                title: Text(
                  'Parking Report',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500, color: black),
                ),
                value: _isParking,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _isParking = value!;
                    if (_type.contains('Parking')) {
                      _type.remove('Parking');
                    } else {
                      _type.add('Parking');
                    }
                  });
                },
              ),
            ),
            ListTileTheme(
              horizontalTitleGap: 0,
              child: CheckboxListTile(
                //contentPadding: EdgeInsets.only(top: 20),
                activeColor: primaryColor,
                selectedTileColor: primaryColor,
                side: BorderSide(color: primaryColor, width: 1.5),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
                title: Text(
                  'Emergency Report',
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500, color: black),
                ),
                value: _isEmergency,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _isEmergency = value!;
      
                    if (_type.contains('Emergency')) {
                      _type.remove('Emergency');
                    } else {
                      _type.add('Emergency');
                    }
                  });
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            // CustomButtonWidget(
            //     buttonTitle: 'Apply',
            //     onBtnPress: () {
            //       widget.onData(_propView ?? 0, _dateRangeValue ?? 0, _from ?? '',
            //           _to ?? '', _type.join(', ').toString());
            //       Navigator.pop(context);
            //     }),
            // SizedBox(
            //   height: 40,
            // )
          ],
        ),
      ),
      bottomNavigationBar:  Container(
         padding: EdgeInsets.symmetric(horizontal: 32),
            margin: EdgeInsets.symmetric(vertical: 30),
        child: CustomButtonWidget(
                  buttonTitle: 'Apply',
                  onBtnPress: () {
                    widget.onData(_propView ?? 0, _dateRangeValue ?? 0, _from ?? '',
                        _to ?? '', _type.join(', ').toString());
                    Navigator.pop(context);
                  }),
      ),
    );
  }
}
