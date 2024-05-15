import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_textfield_widget.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../utils/const.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  List<String> _searchedItems = [];
  List<String> languages = [
    // 'English',
    // 'Deutsch',
    // 'Spanish',
    // 'Language 4 (native)',
    // 'Башҡортса',
    // 'Українська',
    // 'Yorùbá',
    // '中文',
    // 'Кыргызча',
    // 'Português'
    'English',
    'Spanish',
    'Hindi',
    'Arbaic',
    'Manderin',
    'German',
    'French',
    'Italian',
    'Urdu',
    'Benagli',
  ];

 @override
  void initState() {
    super.initState();
    setState(() {
      _searchedItems = languages;
    });
  }

  void filter(String searchText) {
    List<String> results = [];
    if(searchText.isEmpty) {
      results = languages;
    } else {
       results = languages.where((element) => element.toLowerCase().contains(searchText.toLowerCase())).toList();
    }

    setState(() {
      _searchedItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Languages'),
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            SizedBox(
              height: 10.h,
            ),
            // CustomTextField(
            //   textfieldTitle: '',
            //   hintText: 'Search Langauge ',
            //   isFilled: true,
            //   isSearching: true,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                onChanged: ((value) {
                  filter(value);
                }),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: seconderyMediumColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: seconderyMediumColor)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: seconderyMediumColor)),
                  filled: true,
                  fillColor: CustomTheme.seconderyLightColor,
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 25,
                      color: CustomTheme.primaryColor,
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: CustomTheme.primaryColor,
                  ),
                  hintText: 'Search Langauge ',
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _searchedItems.length,
                  itemBuilder: (context, index) {
                    final name = _searchedItems[index];
                    return InkWell(
                      onTap: () {
                        
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index == 0
                              ? CustomTheme.seconderyMediumColor
                              : white,
                        ),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          title: Text(
                            name.toString(),
                            textScaleFactor: 1.0,
                            style:
                                TextStyle(color: CustomTheme.black, fontSize: 13),
                          ),
                          // trailing: index == 0 ? Text('default') : Text(''),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child:
                  CustomButtonWidget(buttonTitle: 'Change', onBtnPress: (

                  ) {
                    
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
