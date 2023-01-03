import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../utils/const.dart';
import '../time_sheet_screen/widgets/check_point_model.dart';

class ActiveMapScreen extends StatefulWidget {
  const ActiveMapScreen({super.key});

  @override
  State<ActiveMapScreen> createState() => _ActiveMapScreenState();
}

class _ActiveMapScreenState extends State<ActiveMapScreen> {
  final Map<String, Marker> _markers = {};

  LatLng currentlocation = const LatLng(22.572645, 88.363892);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
        ),
        elevation: 1,
        shadowColor: seconderyColor,
        centerTitle: true,
        title: Text(
          'Active Properties',
          style: TextStyle(color: black),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
              zoomControlsEnabled: false,
              initialCameraPosition:
                  CameraPosition(target: currentlocation, zoom: 14)),
          Positioned(
            bottom: 10,
            child: SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    margin: EdgeInsets.all(15),
                    height: 120,
                    width: 300,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 90,
                          width: 90,
                          child: Image.network(
                            fit: BoxFit.contain,
                            checkpointData[index].imageUrl,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                checkpointData[index].title,
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                checkpointData[index].isCompleted == 'Complete'
                                    ? 'Check-in by 12:00pm'
                                    : checkpointData[index].isCompleted,
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  checkpointData[index].address,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
