import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/property_details_screen/model/propertyDetail_model.dart';

import 'package:sgt/presentation/property_details_screen/widgets/show_property_images_widget.dart';
import '../../../utils/const.dart';
import '../cubit/showmore/showmore_cubit.dart';
import 'property_media_preview_screen.dart';

class PropertyDescriptionWidget extends StatefulWidget {
  List<PropertyAvatar>? propvatars;
  String? propertyImageBaseUrl;
  String? propDesc;
  PropertyDescriptionWidget(
      {super.key, this.propvatars, this.propertyImageBaseUrl, this.propDesc});

  @override
  State<PropertyDescriptionWidget> createState() =>
      _PropertyDescriptionWidgetState();
}

class _PropertyDescriptionWidgetState extends State<PropertyDescriptionWidget> {
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
                widget.propDesc.toString(),
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
                avatars: widget.propvatars ?? [],
                imageBaseUrl: widget.propertyImageBaseUrl,
              )
            : Container(),
      ],
    );
  }
}
