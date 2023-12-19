import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/property_details_screen/widgets/show_property_images_widget.dart';
import '../../../utils/const.dart';
import '../cubit/showmore/showmore_cubit.dart';
import 'property_media_preview_screen.dart';

class PropertyDescriptionWidget extends StatelessWidget {
  InactiveDatum? activeData = InactiveDatum();
  String? imageBaseUrl;
  PropertyDescriptionWidget({super.key, this.activeData, this.imageBaseUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 300,
              child: Text(
                activeData!.propertyDescription.toString(),
                maxLines:
                    context.watch<ShowmoreCubit>().state.showmore ? 1000 : 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            context.watch<ShowmoreCubit>().state.showmore
                ? Container()
                : InkWell(
                    onTap: () {
                      context.read<ShowmoreCubit>().showMore();
                      print(context.read<ShowmoreCubit>().state.showmore);
                    },
                    child: Text(
                      'more',
                      style: TextStyle(fontSize: 15, color: primaryColor),
                    ),
                  )
          ],
        ),
        context.watch<ShowmoreCubit>().state.showmore
            ? PropertyImagesWidget(
                avatars: activeData!.propertyAvatars,
                imageBaseUrl: imageBaseUrl,
              )
            : Container(),
      ],
    );
  }
}
