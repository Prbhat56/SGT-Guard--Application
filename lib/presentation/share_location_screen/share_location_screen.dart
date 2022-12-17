import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgt/presentation/home.dart';
import '../../utils/const.dart';

class ShareLocationScreen extends StatelessWidget {
  const ShareLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset('assets/icon_marker.png'),
                  const SizedBox(height: 20),
                  const Text(
                    'Hello,and\nWelcome',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Share your location to get started with your services',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: CupertinoButton(
                        disabledColor: seconderyColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 5),
                        color: primaryColor,
                        child: ListTile(
                          leading: Icon(
                            Icons.near_me,
                            color: white,
                          ),
                          title: Text(
                            'Share location',
                            style: TextStyle(fontSize: 17, color: white),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Home();
                          }));
                        }),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'We only access your location while you are using this incredible app',
                    style: TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
