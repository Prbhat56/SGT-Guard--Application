import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/property_details_screen/widgets/show_property_images_widget.dart';
import '../../../utils/const.dart';
import '../cubit/showmore/showmore_cubit.dart';
import 'property_media_preview_screen.dart';

class PropertyDescriptionWidget extends StatelessWidget {
  const PropertyDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 300,
              child: Text(
                'Lorem ipsum dolor sit amet, duo habemus fuisset epicuri ei. No sit tempor populo prodesset, ad cum dicta repudiare. Ex eos probo maluisset, invidunt deseruisse consectetuer id vel, convenire ',
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
            ? PropertyImagesWidget()
            : Container(),
      ],
    );
  }
}
