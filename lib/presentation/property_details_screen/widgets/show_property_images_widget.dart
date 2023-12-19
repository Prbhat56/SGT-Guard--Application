import 'package:flutter/material.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import '../../../helper/navigator_function.dart';
import 'property_media_preview_screen.dart';

class PropertyImagesWidget extends StatelessWidget {
  List<PropertyAvatar>? avatars;
  String? imageBaseUrl;
  PropertyImagesWidget({super.key, required this.avatars, this.imageBaseUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: avatars!.length,
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
                        imageBaseUrl.toString() +
                            '/' +
                            avatars![index].propertyAvatar.toString(),
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
                              PropertyMediaPreviewScreen(
                                avatars: avatars,
                                imageBaseUrl: imageBaseUrl,
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
                            child: Text('+${avatars!.length} - 3',
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
                      PropertyMediaPreviewScreen(
                        avatars: avatars,
                        imageBaseUrl: imageBaseUrl,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      imageBaseUrl.toString() +
                          '/' +
                          avatars![index].propertyAvatar.toString(),
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
