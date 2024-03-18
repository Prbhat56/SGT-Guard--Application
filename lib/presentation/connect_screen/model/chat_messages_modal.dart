class ChatMessages {
  late String type;
  late String message;
  late String toId;
  late String read;
  late String fromId;
  late String sent;
  late bool isSendByMe;

  ChatMessages({
    required this.type,
    required this.message,
    required this.toId,
    required this.read,
    required this.fromId,
    required this.sent,
    required this.isSendByMe,
  });

  ChatMessages.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? "";
    message = json['message'] ?? "";
    toId = json['toId'] ?? "";
    read = json['read'] ?? "";
    fromId = json['fromId'] ?? "";
    sent = json['sent'] ?? "";
    isSendByMe = json['isSendByMe'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['toId'] = this.toId;
    data['read'] = this.read;
    data['fromId'] = this.fromId;
    data['sent'] = this.sent;
    data['isSendByMe'] = this.isSendByMe;
    return data;
  }
}
