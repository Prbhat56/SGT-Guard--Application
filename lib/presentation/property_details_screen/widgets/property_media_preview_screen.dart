import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/property_details_screen/model/propertyDetail_model.dart';

import '../../../utils/const.dart';
import 'property_preview_widget.dart';

class PropertyMediaPreviewScreen extends StatefulWidget {
  List<PropertyAvatar>? avatars;
  String? imageBaseUrl;
  PropertyMediaPreviewScreen(
      {super.key, required this.avatars, this.imageBaseUrl});

  @override
  State<PropertyMediaPreviewScreen> createState() =>
      _PropertyMediaPreviewScreenState();
}

class _PropertyMediaPreviewScreenState
    extends State<PropertyMediaPreviewScreen> {
  final controller = CarouselController();
  int activeIndex = 0;
  // List data = [
  //   'https://images.pexels.com/photos/2957862/pexels-photo-2957862.jpeg?auto=compress&cs=tinysrgb&w=1600',
  //   'https://images.pexels.com/photos/2119714/pexels-photo-2119714.jpeg?auto=compress&cs=tinysrgb&w=1600',
  //   'https://images.pexels.com/photos/2102587/pexels-photo-2102587.jpeg?auto=compress&cs=tinysrgb&w=1600',
  //   'https://player.vimeo.com/external/494276333.hd.mp4?s=84d07ae9c2fbddd1c8fd69a3d7db473be198c478&profile_id=174&oauth2_token_id=57447761'
  // ];

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height * 4.5 / 5);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leadingWidth: 25,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'File name',
          style: TextStyle(color: black),
        ),
      ),
      backgroundColor: black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 4.5 / 5,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            CarouselSlider.builder(
              carouselController: controller,
              itemCount: widget.avatars!.length,
              itemBuilder: (context, index, realIndex) {
                return Stack(
                  children: [
                    index == 3
                        ? Center(child: PropertyVideoPreviewWidget())
                        : Center(
                            child: Image.network(
                              widget.imageBaseUrl.toString() +''+ widget.avatars![index].propertyAvatar
                                      .toString(),
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.contain,
                            ),
                          ),
                    Positioned(
                        top: 20,
                        right: 20,
                        child: Text(
                          "${index + 1}/${widget.avatars!.length}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                );
              },
              options: CarouselOptions(
                initialPage: 0,
                viewportFraction: 1,
                disableCenter: true,
                height: MediaQuery.of(context).size.height * 4.5 / 5,
              ),
            ),
            Positioned(
              top: 350,
              left: 0,
              child: IconButton(
                onPressed: () {
                  controller.previousPage();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: white,
                  size: 35,
                ),
              ),
            ),
            Positioned(
              top: 350,
              right: 0,
              child: IconButton(
                onPressed: () {
                  controller.nextPage();
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: white,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
