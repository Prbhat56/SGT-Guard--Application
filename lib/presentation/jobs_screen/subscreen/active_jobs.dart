import 'package:flutter/material.dart';
import 'package:sgt/presentation/jobs_screen/widgets/job_tiles.dart';

class ActiveJobsTab extends StatelessWidget {
  const ActiveJobsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              // JobsTile(
              //   isActive: true,
              // ),
              JobsTile(isActive: true),
              Divider(
                color: Colors.grey,
              ),
            ],
          );
        });
  }
}
