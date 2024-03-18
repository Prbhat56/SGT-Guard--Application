class GuardLocation {
  late String latitude;
  late String longitude;
  late String timeStamp;
  late String propertyId;
  late String shiftId;
  late String checkpointId;

  GuardLocation({
    required this.latitude,
    required this.longitude,
    required this.timeStamp,
    required this.propertyId,
    required this.shiftId,
    required this.checkpointId,
  });

  GuardLocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'] ?? "";
    longitude = json['longitude'] ?? "";
    timeStamp = json['timeStamp'] ?? "";
    propertyId = json['propertyId'] ?? "";
    shiftId = json['shiftId'] ?? "";
    checkpointId = json['checkpointId'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['timeStamp'] = this.timeStamp;
    data['propertyId'] = this.propertyId;
    data['shiftId'] = this.shiftId;
    data['checkpointId'] = this.checkpointId;
    return data;
  }
}
