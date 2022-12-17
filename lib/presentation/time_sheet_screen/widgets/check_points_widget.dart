import 'package:flutter/material.dart';

import '../../../utils/const.dart';

class CheckPointWidget extends StatelessWidget {
  const CheckPointWidget({super.key, required this.iscompleted});
  final bool iscompleted;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: grey,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 90,
          width: 90,
          child: Image.network(
            fit: BoxFit.contain,
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7d89NKKnm9Lr6fqEt2il6YGOURq0htBmn6A&usqp=CAU',
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Building Hallway 1',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
              iscompleted ? 'Completed' : 'Check-in by 11:00am',
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(
          width: 50,
        ),
        IconButton(
            onPressed: () {},
            icon: iscompleted
                ? Icon(
                    Icons.check_circle,
                    color: greenColor,
                  )
                : const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )),
      ],
    );
  }
}
