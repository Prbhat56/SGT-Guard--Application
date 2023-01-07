// ignore_for_file: public_member_api_docs, sort_constructors_first
class LeaveDetailModel {
  final String imageUrl;
  final String status;
  final String date;
  LeaveDetailModel({
    required this.imageUrl,
    required this.status,
    required this.date,
  });
}

List<LeaveDetailModel> leaveData = [
  LeaveDetailModel(
      imageUrl:
          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
      status: 'Approved',
      date: 'Monday, 23 October'),
  LeaveDetailModel(
      imageUrl:
          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
      status: 'Waiting For Approval',
      date: 'Monday, 23 October'),
  LeaveDetailModel(
      imageUrl:
          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
      status: 'Not Approved',
      date: 'Monday, 13 October'),
  LeaveDetailModel(
      imageUrl:
          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
      status: 'Not Approved',
      date: 'Monday, 03 October'),
];
