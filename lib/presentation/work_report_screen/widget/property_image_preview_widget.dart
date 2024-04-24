import 'package:flutter/material.dart';
import 'package:sgt/presentation/work_report_screen/model/checkPoint_model.dart';
import 'package:sgt/presentation/work_report_screen/widget/property_image_preview.dart';
import '../../../helper/navigator_function.dart';

class PropertyImagesPreviewWidget extends StatefulWidget {
  List<PropertyAvatar>? avatars;
  String? propertyImageBaseUrl;
  PropertyImagesPreviewWidget({super.key, required this.avatars, this.propertyImageBaseUrl});

  @override
  State<PropertyImagesPreviewWidget> createState() => _PropertyImagesPreviewWidgetState();
}

class _PropertyImagesPreviewWidgetState extends State<PropertyImagesPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
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
                        widget.propertyImageBaseUrl.toString()+''+
                            widget.avatars![index].propertyAvatar.toString(),
                        height: 88,
                        width: 122,
                        fit: BoxFit.fill,
                      ),
                    ),
                    //using opacity to mask the image
                    Opacity(
                      opacity: 0.5,
                      child: InkWell(
                        onTap: () {
                          screenNavigator(
                              context,
                              PropertyImageMediaPreviewScreen(
                                avatars: widget.avatars,
                                imageBaseUrl: widget.propertyImageBaseUrl,
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
                    )
                  ],
                ),
              )
            : InkWell(
                onTap: () {
                  screenNavigator(
                      context,
                      PropertyImageMediaPreviewScreen(
                        avatars: widget.avatars,
                        imageBaseUrl: widget.propertyImageBaseUrl,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      widget.propertyImageBaseUrl.toString() +
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
    );
  }
}
