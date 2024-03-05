class ChatUsers {
  late String profileUrl;
  late String name;
  late String createdAt;
  late bool isOnline;
  late String id;
  late String lastActive;
  late String email;
  late String pushToken;
  late String location;
  late String position;
  late String recentMessageTimestamp;

  ChatUsers({
    required this.profileUrl,
    required this.name,
    required this.createdAt,
    required this.isOnline,
    required this.id,
    required this.lastActive,
    required this.email,
    required this.pushToken,
    required this.location,
    required this.position,
    required this.recentMessageTimestamp,
  });

  ChatUsers.fromJson(Map<String, dynamic> json) {
    profileUrl = json['profileUrl'] ?? "";
    name = json['name'] ?? "";
    createdAt = json['createdAt'] ?? "";
    isOnline = json['isOnline'] ?? false;
    id = json['id'] ?? "";
    lastActive = json['last_active'] ?? "";
    email = json['email'] ?? "";
    pushToken = json['push_token'] ?? "";
    location = json['location'] ?? "";
    position = json['position'] ?? "";
    recentMessageTimestamp = json['recentMessageTimestamp'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileUrl'] = this.profileUrl;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['isOnline'] = this.isOnline;
    data['id'] = this.id;
    data['last_active'] = this.lastActive;
    data['email'] = this.email;
    data['push_token'] = this.pushToken;
    data['location'] = this.location;
    data['position'] = this.position;
    data['recentMessageTimestamp'] = this.recentMessageTimestamp;
    return data;
  }
}
