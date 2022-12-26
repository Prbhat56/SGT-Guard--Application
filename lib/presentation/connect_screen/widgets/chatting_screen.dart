import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sgt/presentation/connect_screen/widgets/chat_model.dart';
import 'package:sgt/presentation/connect_screen/widgets/media_preview_screen.dart';
import 'package:sgt/presentation/connect_screen/widgets/send_message_widget.dart';
import 'package:sgt/presentation/connect_screen/widgets/share_to_connect_screen.dart';
import '../../../utils/const.dart';
import 'image_message.dart';
import 'received_message_widget.dart';
import 'package:image_picker/image_picker.dart';

import 'video_preview.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key, required this.index});
  final int index;
  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final ImagePicker _picker = ImagePicker();
  List selectedChatTile = [];
  bool selectMedia = false;
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar:
            // BlocProvider.of<MessagePressedCubit>(context, listen: true)
            //         .state
            //         .messagelongpressed
            selectedChatTile.isNotEmpty
                ? AppBar(
                    elevation: 0,
                    leadingWidth: 0,
                    backgroundColor: white,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: [
                      // InkWell(
                      //   onTap: () {
                      //     print('share');
                      //   },
                      //   child: Image.asset(
                      //     'assets/share.png',
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShareToConnection()));
                        },
                        icon: Icon(
                          LineIcons.upload,
                          color: black,
                          size: 30,
                        ),
                        // icon: FaIcon(
                        //   FontAwesomeIcons.upload,
                        //   color: black,
                        //   size: 25,
                        // ),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0))),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Delete media?',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Text(
                                            'Are you sure you want to delete this media?',
                                            textAlign: TextAlign.center,
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Divider(
                                          height: 0,
                                          color: Colors.grey,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  border: Border.all(
                                                      color: primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Cencel',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 70,
                                              ),
                                              Container(
                                                height: 40,
                                                width: 1,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 65,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  border: Border.all(
                                                      color: primaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Delete',
                                                    textScaleFactor: 1.0,
                                                    style: TextStyle(
                                                        color: white,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: black,
                            size: 25,
                          ))
                    ],
                  )
                : AppBar(
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
                                      border:
                                          Border.all(color: white, width: 2),
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
                  ),
        backgroundColor: white,
        body: ListView(
          children: [
            ListTile(
              tileColor: selectedChatTile.contains(1) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(1);
                });
                print(selectedChatTile.contains(1));
              },
              onTap: () {
                setState(() {
                  selectedChatTile.remove(1);
                });
              },
              title: SentMessageScreen(
                  message:
                      "Hey John, I need you to head over to the leasing office to check up on the back door."),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 4 / 5),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            ListTile(
                tileColor: selectedChatTile.contains(2) ? seconderyColor : null,
                onLongPress: () {
                  setState(() {
                    selectedChatTile.add(2);
                  });
                },
                onTap: () {
                  setState(() {
                    selectedChatTile.remove(2);
                  });
                },
                title: ReceivedMessageScreen(message: "Sure!")),
            ListTile(
                tileColor: selectedChatTile.contains(3) ? seconderyColor : null,
                onLongPress: () {
                  setState(() {
                    selectedChatTile.add(3);
                  });
                },
                onTap: () {
                  setState(() {
                    selectedChatTile.remove(3);
                  });
                },
                title: ReceivedMessageScreen(
                    message: "Should I look for something?")),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            ListTile(
                tileColor: selectedChatTile.contains(4) ? seconderyColor : null,
                onLongPress: () {
                  setState(() {
                    selectedChatTile.add(4);
                  });
                },
                onTap: () {
                  setState(() {
                    selectedChatTile.remove(4);
                  });
                },
                title: SentMessageScreen(message: "No we are all good")),
            ListTile(
              tileColor: selectedChatTile.contains(5) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(5);
                });
              },
              onTap: () {
                setState(() {
                  selectedChatTile.remove(5);
                });
              },
              title: SentMessageScreen(
                  message:
                      "A tenant brought up a concern about a open door and there might be someone there."),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 4 / 5),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            ListTile(
                tileColor: selectedChatTile.contains(6) ? seconderyColor : null,
                onLongPress: () {
                  setState(() {
                    selectedChatTile.add(6);
                  });
                },
                onTap: () {
                  setState(() {
                    selectedChatTile.remove(6);
                  });
                },
                title: ReceivedMessageScreen(message: "Ok I will check ")),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            ListTile(
              tileColor: selectedChatTile.contains(7) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(7);
                });
              },
              onTap: () {
                setState(() {
                  selectedChatTile.remove(7);
                });
              },
              title: SentMessageScreen(message: "Can we meet tomorrow?"),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 4 / 5),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            ListTile(
              tileColor: selectedChatTile.contains(8) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(8);
                });
              },
              onTap: () {
                setState(() {
                  selectedChatTile.remove(8);
                });
              },
              title: ReceivedMessageScreen(
                  message: "Yes, of course we will meet tomorrow"),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            ListTile(
              tileColor: selectedChatTile.contains(9) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(9);
                });
              },
              onTap: () {
                selectedChatTile.contains(9)
                    ? setState(() {
                        selectedChatTile.remove(9);
                      })
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MediaPreviewScreen(index: widget.index)));
              },
              title: ImageMessage(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 15),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              tileColor: selectedChatTile.contains(10) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(10);
                });
              },
              onTap: () {
                setState(() {
                  selectedChatTile.remove(10);
                });
              },
              title: VideoPreviewWidget(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 0, bottom: 15),
              child: Text(
                '10.23 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 120),
              child: ListTile(
                tileColor:
                    selectedChatTile.contains(11) ? seconderyColor : null,
                onLongPress: () {
                  setState(() {
                    selectedChatTile.add(11);
                  });
                },
                onTap: () {
                  setState(() {
                    selectedChatTile.remove(11);
                  });
                },
                title: Stack(
                  children: [
                    Image.network(
                      'https://images.pexels.com/photos/5702958/pexels-photo-5702958.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      height: 150,
                    ),
                    Positioned(
                      top: 250,
                      child: Center(
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                            child: Container(
                              child: Text(''),
                            )),
                      ),
                    ),
                    Positioned(
                        top: 60,
                        left: 70,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                color: black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.download_outlined,
                                  color: white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Retry',
                                  style: TextStyle(color: white),
                                ),
                              ],
                            ))),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 4 / 5, bottom: 15),
              child: Row(
                children: [
                  Text(
                    '10.30 A.M.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Icon(Icons.av_timer, size: 17.sp, color: Colors.grey),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              tileColor: selectedChatTile.contains(7) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(7);
                });
              },
              onTap: () {
                setState(() {
                  selectedChatTile.remove(7);
                });
              },
              title: SentMessageScreen(
                  message:
                      "A tenant brought up a concern about a open door and there might be someone there."),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 4 / 5),
              child: Row(
                children: [
                  Text(
                    '10.30 A.M.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Icon(Icons.av_timer, size: 17.sp, color: Colors.grey),
                ],
              ),
            ),
            ListTile(
              tileColor: selectedChatTile.contains(9) ? seconderyColor : null,
              onLongPress: () {
                setState(() {
                  selectedChatTile.add(9);
                });
              },
              onTap: () {
                selectedChatTile.contains(9)
                    ? setState(() {
                        selectedChatTile.remove(9);
                      })
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MediaPreviewScreen(index: widget.index)));
              },
              title: ImageMessage(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '10.30 A.M.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 2.0, color: Colors.grey),
              ),
              color: Colors.white,
            ),
            height: 60,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              selectMedia
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 25),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Select Media From?',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const Text(
                                          'Use camera or select file from device gallery',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 109, 109, 109)),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                // Capture a photo
                                                final XFile? photo =
                                                    await _picker.pickImage(
                                                        source:
                                                            ImageSource.camera);

                                             
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      color: grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Icon(
                                                      Icons.camera_alt,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  const Text('Camera')
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                         

                                                // Pick multiple images
                                                final List<XFile>? images =
                                                    await _picker
                                                        .pickMultiImage();
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      color: white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: const Offset(
                                                              0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons.photo_outlined,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  const Text('Gallery')
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                            setState(() {
                              selectMedia = false;
                            });
                          },
                          icon: Icon(
                            Icons.photo_rounded,
                            color: primaryColor,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 25),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Select Media From?',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const Text(
                                          'Use camera or select file from device gallery',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 109, 109, 109)),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                final XFile? video =
                                                    await _picker.pickVideo(
                                                        source:
                                                            ImageSource.camera);
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      color: grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Icon(
                                                      Icons.camera_alt,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  const Text('Camera')
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                final XFile? video =
                                                    await _picker.pickVideo(
                                                        source: ImageSource
                                                            .gallery);
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      color: white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: const Offset(
                                                              0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                      Icons.photo_outlined,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  const Text('Gallery')
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                            setState(() {
                              selectMedia = false;
                            });
                          },
                          icon: Icon(
                            Icons.videocam_rounded,
                            color: primaryColor,
                            size: 30,
                          ),
                        )
                      ],
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          selectMedia = true;
                        });
                      },
                      icon: Icon(
                        Icons.add_circle_sharp,
                        color: primaryColor,
                        size: 30,
                      )),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: grey,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: grey),
                    ),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(color: grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: grey)),
                    hintText: 'Write a message',
                  ),
                  onTap: () {
                    setState(() {
                      selectMedia = false;
                    });
                  },
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send_rounded,
                    color: primaryColor,
                    size: 35,
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
