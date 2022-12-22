class CheckPointModel {
  final String title;
  final String isCompleted;
  final String imageUrl;
  final String address;

  CheckPointModel(
      {required this.title,
      required this.isCompleted,
      required this.imageUrl,
      required this.address});
}

List<CheckPointModel> checkpointData = [
  CheckPointModel(
    title: 'Building Hallway 1',
    isCompleted: 'Complete',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7d89NKKnm9Lr6fqEt2il6YGOURq0htBmn6A&usqp=CAU',
    address: "43 Bourke Street, Newbridge ",
  ),
  CheckPointModel(
    title: 'Building Hallway 2',
    isCompleted: 'Complete',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7d89NKKnm9Lr6fqEt2il6YGOURq0htBmn6A&usqp=CAU',
    address: "43 Bourke Street, Newbridge ",
  ),
  CheckPointModel(
    title: 'Main Court Yard',
    isCompleted: 'Check-in by 11:00am',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7d89NKKnm9Lr6fqEt2il6YGOURq0htBmn6A&usqp=CAU',
    address: "43 Bourke Street, Newbridge ",
  ),
  CheckPointModel(
    title: 'Parking Structure 1',
    isCompleted: 'Check-in by 11:30am',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7d89NKKnm9Lr6fqEt2il6YGOURq0htBmn6A&usqp=CAU',
    address: "43 Bourke Street, Newbridge ",
  ),
  CheckPointModel(
    title: 'Parking Structure 2',
    isCompleted: 'Check-in by 12:00pm',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7d89NKKnm9Lr6fqEt2il6YGOURq0htBmn6A&usqp=CAU',
    address: "43 Bourke Street, Newbridge ",
  ),
  CheckPointModel(
    title: 'Parking Structure 3',
    isCompleted: 'Check-in by 12:00pm',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7d89NKKnm9Lr6fqEt2il6YGOURq0htBmn6A&usqp=CAU',
    address: "43 Bourke Street, Newbridge ",
  ),
  CheckPointModel(
    title: 'Leasing Office',
    isCompleted: 'Check-in by 12:00pm',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7d89NKKnm9Lr6fqEt2il6YGOURq0htBmn6A&usqp=CAU',
    address: "43 Bourke Street, Newbridge ",
  ),
];
