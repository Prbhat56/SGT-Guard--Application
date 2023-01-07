import 'package:flutter/material.dart';
import '../../../utils/const.dart';
import '../../property_details_screen/property_details_screen.dart';

class LocationDetailsCard extends StatefulWidget {
  const LocationDetailsCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.address,
      required this.duty,
      required this.imageUrl});
  final String title;
  final String subtitle;
  final String address;
  final String duty;
  final String imageUrl;
  @override
  State<LocationDetailsCard> createState() => _LocationDetailsCardState();
}

class _LocationDetailsCardState extends State<LocationDetailsCard> {
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
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
widget.imageUrl,)),
                  borderRadius: BorderRadius.circular(20),
                  color: grey,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    widget.duty,
                    style: TextStyle(fontSize: 17, color: primaryColor),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    color: primaryColor,
                    size: 15,
                  ),
                  Text(
                    widget.subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  widget.address,
                  style: TextStyle(fontSize: 13, color: black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
