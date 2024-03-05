import 'package:flutter/material.dart';
import 'package:sgt/presentation/jobs_screen/model/dutyList_model.dart';
import 'package:sgt/presentation/jobs_screen/widgets/job_tiles.dart';

class ActiveJobsTab extends StatefulWidget {
  List<InactiveDatum> activeData = [];
  String imageBaseUrl;
  String? propertyImageBaseUrl;
  ActiveJobsTab({
    Key? key,
    required this.activeData,
    required this.imageBaseUrl, 
    this.propertyImageBaseUrl,
  }) : super(key: key);

  @override
  State<ActiveJobsTab> createState() => _ActiveJobsTabState();
}

class _ActiveJobsTabState extends State<ActiveJobsTab> {
  @override
  Widget build(BuildContext context) {
    return widget.activeData.isEmpty
        ? SizedBox(
            child: Center(
              child:  Text(
                'No Active Jobs Found',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Container(
              //       width: 120,
              //       child: Image.asset(
              //         'assets/no_active_properties.png',
              //         fit: BoxFit.contain,
              //       ),
              //     ),
              //     SizedBox(
              //       height: 24,
              //     ),
              //     Text(
              //       'No Active Properties',
              //       style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17,color:Colors.grey.withOpacity(0.6)),
              //     ),
              //   ],
              // ),
            ),
          )
        : ListView.builder(
            itemCount: widget.activeData.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  JobsTile(
                    isActive: true,
                    inActiveData: widget.activeData[index],
                    imageBaseUrl: widget.imageBaseUrl,
                    propertyImageBaseUrl:widget.propertyImageBaseUrl,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                ],
              );
            });
  }
}
