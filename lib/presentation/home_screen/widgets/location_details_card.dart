import 'package:flutter/material.dart';
import '../../../utils/const.dart';
import '../../property_details_screen/property_details_screen.dart';

class LocationDetailsCard extends StatelessWidget {
  const LocationDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PropertyDetailsScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 204,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg')),
                  borderRadius: BorderRadius.circular(20),
                  color: grey,
                ),
              ),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(20),
              //   child: Image.network(
              //     'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Rivi Properties',
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    'Guard Post Duties',
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
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
                    'Guard Post Duties',
                    style: TextStyle(fontSize: 17, color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Los Angeles California, 90293 ',
                style: TextStyle(fontSize: 17, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
