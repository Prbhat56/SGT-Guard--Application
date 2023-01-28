import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/connect_screen/widgets/chat_model.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/const.dart';
import 'delete_dialog.dart';
import 'share_to_connect_screen.dart';

class MediaPreviewScreen extends StatefulWidget {
  const MediaPreviewScreen({super.key, required this.index});
  final int index;
  @override
  State<MediaPreviewScreen> createState() => _MediaPreviewScreenState();
}

class _MediaPreviewScreenState extends State<MediaPreviewScreen> {
  final controller = CarouselController();
  int activeIndex = 0;
  List data = [
    'https://images.pexels.com/photos/2957862/pexels-photo-2957862.jpeg?auto=compress&cs=tinysrgb&w=1600',
    'https://images.pexels.com/photos/2119714/pexels-photo-2119714.jpeg?auto=compress&cs=tinysrgb&w=1600',
    'https://images.pexels.com/photos/2102587/pexels-photo-2102587.jpeg?auto=compress&cs=tinysrgb&w=1600',
  ];

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height * 4.5 / 5);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: black,
              size: 30,
            ),
          ),
        ),
        leadingWidth: 25,
        title: ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: grey,
                backgroundImage: NetworkImage(
                  dummyData[widget.index].profileUrl,
                ),
              ),
              dummyData[widget.index].isOnline
                  ? Positioned(
                      top: 26,
                      left: 26,
                      child: Container(
                        height: 13,
                        width: 13,
                        decoration: BoxDecoration(
                          color: greenColor,
                          border: Border.all(color: white, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    )
                  : Positioned(
                      top: 40,
                      left: 40,
                      child: Container(),
                    )
            ],
          ),
          title: Text(dummyData[widget.index].name),
          subtitle: dummyData[widget.index].isOnline
              ? const Text("Active Now")
              : const Text("Not Active"),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: black,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                  height: 20,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteDialog();
                          });
                    },
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: CustomTheme.primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Delete",
                              style: TextStyle(
                                color: CustomTheme.primaryColor,
                              )),
                        ],
                      ),
                    ),
                  )),
              PopupMenuItem(
                  height: 0,
                  child: Divider(
                    height: 0,
                    color: CustomTheme.primaryColor,
                  )),
              PopupMenuItem(
                height: 40,
                child: InkWell(
                  onTap: () {
                    screenNavigator(context, ShareToConnection());
                  },
                  child: Container(
                    height: 20,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.upload_outlined,
                          color: CustomTheme.primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Share",
                            style: TextStyle(
                              color: CustomTheme.primaryColor,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 4.5 / 5,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: data.length,
                  itemBuilder: (context, index, realIndex) {
                    return Stack(
                      children: [
                        Image.network(
                          data[index],
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            top: 20,
                            right: 20,
                            child: Text(
                              "${index + 1}/${data.length}",
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
        ],
      ),
    );
  }
}
