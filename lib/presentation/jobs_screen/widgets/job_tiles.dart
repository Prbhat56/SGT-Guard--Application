import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/property_details_screen/widgets/property_details_screen.dart';
import 'package:sgt/utils/const.dart';
import '../../property_details_screen/inactive_property_details_screen.dart';
import '../../widgets/custom_circular_image_widget.dart';

class JobsTile extends StatefulWidget {
  final bool isActive;
  InactiveDatum? inActiveData = InactiveDatum();
  String? imageBaseUrl;
  String? propertyImageBaseUrl;
  int? propertyId;
  JobsTile({
    super.key,
    required this.isActive,
    this.inActiveData,
    this.imageBaseUrl, 
    this.propertyImageBaseUrl,
  });

  @override
  State<JobsTile> createState() => _JobsTileState();
}

class _JobsTileState extends State<JobsTile> {
  @override
  Widget build(BuildContext context) {
    final bool isActive = widget.isActive;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            // print(widget.inActiveData!.propertyName.toString());
            isActive
                ? screenNavigator(
                    context,
                    PropertyDetailsScreen(
                      imageBaseUrl: widget.imageBaseUrl,
                      activeData: widget.inActiveData,
                      propertyId: widget.inActiveData!.id,
                      propertyImageBaseUrl: widget.propertyImageBaseUrl,
                    ))
                : screenNavigator(
                    context,
                    InActivePropertyDetailsScreen(
                      propertyId: widget.inActiveData!.id,
                    ));
          },
          child: Row(
            children: [
              CustomCircularImage.getlgCircularImage(
                  widget.propertyImageBaseUrl ?? "",
                  widget.inActiveData!.propertyAvatars!.first.propertyAvatar
                      .toString(),
                  isActive),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Text(
                        widget.inActiveData!.propertyName!.toString(),
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: primaryColor,
                          size: 17,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              widget.inActiveData!.location!.toString(),
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 22.0, top: 6, right: 20),
                      child: Text(
                        widget.inActiveData!.propertyDescription!.toString(),
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 75, 75, 75),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
