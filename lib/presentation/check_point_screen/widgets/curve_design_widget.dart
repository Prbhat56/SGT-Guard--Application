import 'package:flutter/material.dart';
import 'check_point_card_wieget.dart';

class CurveDesignWidget extends StatelessWidget {
  const CurveDesignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Stack(
        children: [
          Image.network(
            'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/curve.png'),
            )),
            height: 300,
          ),
          Positioned(
            top: 260,
            left: 16,
            right: 16,
            child: CheckPointCardsWidget(),
          ),
        ],
      ),
    );
  }
}
