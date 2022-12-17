import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sgt/presentation/jobs_screen/widgets/active_jobs.dart';
import 'package:sgt/presentation/jobs_screen/widgets/inactive_jobs.dart';

import '../../utils/const.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          leadingWidth: 20,
          elevation: 0,
          toolbarHeight: 80,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(3, 3, 3, 0),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.close)),
            ),
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                TabBar(
                  labelColor: black,
                  unselectedLabelColor: Colors.grey,
                  indicatorWeight: 4,
                  indicatorColor: primaryColor,
                  tabs: [
                    Tab(
                      icon: Text(
                        'Active',
                        style: TextStyle(color: black, fontSize: 20),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        'Inactive',
                        style: TextStyle(color: black, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 700,
                  child: TabBarView(children: [
                    ActiveJobsTab(),
                    InactiveJobsTab(),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class QuickPay extends StatelessWidget {
//   const QuickPay({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(
//             color: primaryColor,
//           ),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Center(
//               child: Text(
//                 "QuickPay",
//                 style: TextStyle(
//                   color: primaryColor,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 3,
//             ),
//             Center(
//                 child: Text(
//               "Enter your details to recharge",
//               style: TextStyle(color: greyColor),
//             )),
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: Container(
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                         blurRadius: 1,
//                         spreadRadius: 2,
//                         color: primaryColor.withOpacity(0.1))
//                   ],
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 child: TabBar(
//                     labelColor: Colors.white,
//                     unselectedLabelColor: primaryColor,
//                     indicator: BoxDecoration(
//                       color: primaryColor,
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     tabs: [
//                       Tab(
//                         icon: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: const [
//                             Icon(Icons.live_tv),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text("Cable TV")
//                           ],
//                         ),
//                       ),
//                       Tab(
//                         icon: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: const [
//                             Icon(Icons.indeterminate_check_box),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text("Broadband")
//                           ],
//                         ),
//                       ),
//                     ]),
//               ),
//             ),
//             const Expanded(
//               child: TabBarView(children: [
//                 QuickCable(),
//                 QuickBroadband(),
//               ]),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
