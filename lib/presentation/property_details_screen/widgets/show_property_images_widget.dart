import 'package:flutter/material.dart';
import '../../../helper/navigator_function.dart';
import 'property_media_preview_screen.dart';

class PropertyImagesWidget extends StatelessWidget {
  const PropertyImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) => index ==
                2 //using index to show the masked image by ternary operator
            ? Padding(
                padding: const EdgeInsets.all(0.5),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                        height: 88,
                        width: 122,
                      ),
                    ),
                    //using opacity to mask the image
                    Opacity(
                      opacity: 0.5,
                      child: InkWell(
                        onTap: () {
                          screenNavigator(
                              context, PropertyMediaPreviewScreen());
                        },
                        child: Container(
                          height: 85,
                          width: 122,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text('+2',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : InkWell(
                onTap: () {
                  screenNavigator(context, PropertyMediaPreviewScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.all(0.5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
                      height: 88,
                      width: 122,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
