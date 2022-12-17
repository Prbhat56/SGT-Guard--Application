import 'package:flutter/material.dart';
import 'package:sgt/presentation/property_details_screen/property_details_screen.dart';
import 'package:sgt/utils/const.dart';

class JobsTile extends StatelessWidget {
  const JobsTile({super.key, required this.isActive});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PropertyDetailsScreen()));
          },
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                    ),
                  ),
                  isActive
                      ? Positioned(
                          top: 43,
                          left: 40,
                          child: Container(
                            height: 17,
                            width: 17,
                            decoration: BoxDecoration(
                              border: Border.all(color: white, width: 3),
                              color: greenColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Rivi Properties',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 17,
                      ),
                      Text(
                        '1517 South Centelella',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 18.0),
                    child: Text(
                      'Guard Post Duties',
                      style: TextStyle(
                          fontSize: 17, color: Color.fromARGB(255, 75, 75, 75)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
