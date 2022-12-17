import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/const.dart';
import '../connect_screen/widgets/chat_model.dart';
import '../work_report_screen/work_report_screen.dart';

class AllTeamMemberScreen extends StatefulWidget {
  const AllTeamMemberScreen({super.key});

  @override
  State<AllTeamMemberScreen> createState() => _AllTeamMemberScreenState();
}

class _AllTeamMemberScreenState extends State<AllTeamMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: white,
        leading: Icon(
          Icons.check_circle,
          color: greenColor,
        ),
        title: Text(
          'Greylock Security',
          style: TextStyle(color: black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.map,
                color: black,
                size: 30,
              )),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WorkReportScreen()));
                },
                icon: Icon(
                  Icons.add,
                  color: black,
                  size: 30,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Team',
                style: TextStyle(
                    color: black, fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 4 / 5,
            child: ListView.builder(
                itemCount: dummyData.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 40,
                            backgroundColor: grey,
                            backgroundImage: NetworkImage(
                              dummyData[index].profileUrl,
                            ),
                          ),
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dummyData[index].name,
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                dummyData[index].location,
                                style:
                                    TextStyle(fontSize: 17, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          subtitle: Text(
                            dummyData[index].position,
                            style: TextStyle(fontSize: 15, color: black),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      )),
    );
  }
}
