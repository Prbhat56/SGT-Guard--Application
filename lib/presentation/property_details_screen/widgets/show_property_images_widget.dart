import 'package:flutter/material.dart';
import 'package:sgt/presentation/property_details_screen/model/propertyDetail_model.dart';

import '../../../helper/navigator_function.dart';
import 'property_media_preview_screen.dart';

class PropertyImagesWidget extends StatefulWidget {
  List<PropertyAvatar>? avatars;
  String? imageBaseUrl;
  PropertyImagesWidget({super.key, required this.avatars, this.imageBaseUrl});

  @override
  State<PropertyImagesWidget> createState() => _PropertyImagesWidgetState();
}

class _PropertyImagesWidgetState extends State<PropertyImagesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.avatars!.length,
          itemBuilder: (context, index) => index ==
                  2 //using index to show the masked image by ternary operator
              ? Padding(
                  padding: const EdgeInsets.all(3),
                  child: Stack(
                    children: [
                      ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          widget.imageBaseUrl.toString() +
                              '' +
                              widget.avatars![index].propertyAvatar.toString(),
                          height: 88,
                          width: 122,
                          fit: BoxFit.fill,
                        ),
                      ),
                      //using opacity to mask the image
                      widget.avatars!.length > 3 ?
                      Opacity(
                        opacity: 0.5,
                        child: InkWell(
                          onTap: () {
                            screenNavigator(
                                context,
                                PropertyMediaPreviewScreen(
                                  avatars: widget.avatars,
                                  imageBaseUrl: widget.imageBaseUrl,
                                ));
                          },
                          child: Container(
                            height: 85,
                            width: 122,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text('+${widget.avatars!.length-3}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ):Container()
                    ],
                  ),
                )
              : InkWell(
                  onTap: () {
                    screenNavigator(
                        context,
                        PropertyMediaPreviewScreen(
                          avatars: widget.avatars,
                          imageBaseUrl: widget.imageBaseUrl,
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        widget.imageBaseUrl.toString() +
                            '/' +
                            widget.avatars![index].propertyAvatar.toString(),
                        height: 88,
                        width: 122,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
