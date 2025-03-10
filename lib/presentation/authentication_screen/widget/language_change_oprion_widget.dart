import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgt/presentation/widgets/custom_underline_textfield_widget.dart';
import '../../../utils/const.dart';

class LanguageChangeOptionWidget extends StatelessWidget {
  const LanguageChangeOptionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final List locale =[
    {'name':'ENGLISH','locale': Locale('en','US')},
    {'name':'Spanish','locale': Locale('es','ES')},
    {'name':'हिंदी','locale': Locale('hi','IN')},
    {'name':'Arabic','locale': Locale('ar','IN')},
    {'name':'Manderin','locale': Locale('zh','IN')},
    {'name':'German','locale': Locale('de','IN')},
    {'name':'French','locale': Locale('fr','IN')},
    {'name':'Italian','locale': Locale('it','IN')},
    {'name':'Urdu','locale': Locale('ur','IN')},
    {'name':'Bengali','locale': Locale('bn','IN')},
  ];



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
      'Bengali',
    ];

    updateLanguage(Locale locale){
    Get.updateLocale(locale);
    Get.back();
  }
    return Center(
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            context: context,
            builder: (context) => ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: Container(
                height: 530.h,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(25)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 24),
                      color: white,
                      child: Center(
                        child: Text(
                          'Change Language',
                          textScaleFactor: 1.0,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: white,
                        border: Border(
                          bottom: BorderSide(
                            width: 4.0,
                            color: grey,
                          ),
                        ),
                      ),

                      // child: CustomUnderlineTextFieldWidget(
                      //       // bottomPadding: 7,
                      //       textfieldTitle: '',
                      //       hintText: 'Search Language',
                      //       controller: _searchLanguageController,
                      //       onChanged: (value) {
                      //       },
                      //     ),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: grey),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: grey),
                          ),
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search Language',
                          hintStyle: GoogleFonts.montserrat(
                              textStyle: TextStyle(color: grey, fontSize: 17)),
                          focusColor: primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: locale.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 2.0, color: grey),
                                ),
                              ),
                              child: GestureDetector(
                                onTap:(){
                                  print("Language ========> ${locale[index]['name']}");
                                  updateLanguage(locale[index]['locale']);
                                },
                                child: Center(
                                  child: Text(
                                    locale[index]['name'],
                                    textScaleFactor: 1.0,
                                    style: GoogleFonts.montserrat(
                                      textStyle:
                                          TextStyle(color: black, fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Fontisto.world_o,
              size: 17,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
                textScaleFactor: 1.0,
                'English',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 17),
                )),
            const SizedBox(
              width: 5,
            ),
            const Icon(Icons.keyboard_arrow_down)
          ],
        ),
      ),
    );
  }
}
