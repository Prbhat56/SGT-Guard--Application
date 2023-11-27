import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/connect_screen/widgets/chatting_screen.dart';
import 'package:sgt/presentation/widgets/custom_circular_image_widget.dart';
import 'package:sgt/presentation/widgets/main_appbar_widget.dart';
import '../../theme/custom_theme.dart';
import '../../utils/const.dart';
import '../connect_screen/widgets/chat_model.dart';

class AllTeamMemberScreen extends StatefulWidget {
  const AllTeamMemberScreen({super.key});

  @override
  State<AllTeamMemberScreen> createState() => _AllTeamMemberScreenState();
}

class _AllTeamMemberScreenState extends State<AllTeamMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: MainAppBarWidget(appBarTitle: 'Greylock Security'),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child:
                    Text('Team', style: CustomTheme.textField_Headertext_Style),
              ),
              Container(
                //giving height to the list view by multiplying
                //the height of one widget with length of data
                height: 74 * dummyData.length.toDouble(),
                child: ListView.builder(
                    itemCount: dummyData.length,
                    physics:
                        NeverScrollableScrollPhysics(), //stoping default scrolling behaviour
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          screenNavigator(
                              context, ChattingScreen(index: index));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                children: [
                                  CustomCircularImage.getCircularImage(
                                      '',
                                      dummyData[index].profileUrl,
                                      false,
                                      25,
                                      4,
                                      43),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dummyData[index].name,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        dummyData[index].location,
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        dummyData[index].position,
                                        style: TextStyle(
                                            fontSize: 12, color: black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                              height: 20,
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
