import 'dart:convert';

DutyListModel dutyModelFromJson(String str) =>
    DutyListModel.fromJson(json.decode(str));

String dutyModelToJson(DutyListModel data) => json.encode(data.toJson());

class DutyListModel {
  List<InactiveDatum>? activeData;
  List<InactiveDatum>? inactiveData;
  String? imageBaseUrl;
  String? propertyImageBaseUrl;
  int? status;

  DutyListModel({
    this.activeData,
    this.inactiveData,
    this.imageBaseUrl,
    this.propertyImageBaseUrl,
    this.status,
  });

  factory DutyListModel.fromRawJson(String str) =>
      DutyListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DutyListModel.fromJson(Map<String, dynamic> json) => DutyListModel(
        activeData: json["active_data"] == null
            ? []
            : List<InactiveDatum>.from(
                json["active_data"]!.map((x) => InactiveDatum.fromJson(x))),
        inactiveData: json["inactive_data"] == null
            ? []
            : List<InactiveDatum>.from(
                json["inactive_data"]!.map((x) => InactiveDatum.fromJson(x))),
        imageBaseUrl: json["image_base_url"],
        propertyImageBaseUrl: json["property_image_base_url"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "active_data": activeData == null
            ? []
            : List<dynamic>.from(activeData!.map((x) => x.toJson())),
        "inactive_data": inactiveData == null
            ? []
            : List<dynamic>.from(inactiveData!.map((x) => x.toJson())),
        "image_base_url": imageBaseUrl,
        "property_image_base_url": propertyImageBaseUrl,
        "status": status,
      };
}

class InactiveDatum {
  int? id;
  int? propertyOwnerId;
  String? propertyName;
  String? type;
  int? assignStaff;
  String? area;
  String? country;
  String? state;
  String? city;
  String? postCode;
  String? propertyDescription;
  String? location;
  String? longitude;
  String? latitude;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? latestShiftDate;
  String? latestShiftTime;
  String? latestShiftClockIn;
  String? latestShiftClockOut;
  List<PropertyAvatar>? propertyAvatars;
  List<Shift>? shifts;
  List<CheckPoint>? checkPoints;

  InactiveDatum({
    this.id,
    this.propertyOwnerId,
    this.propertyName,
    this.type,
    this.assignStaff,
    this.area,
    this.country,
    this.state,
    this.city,
    this.postCode,
    this.propertyDescription,
    this.location,
    this.longitude,
    this.latitude,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.latestShiftTime,
    this.latestShiftDate,
    this.latestShiftClockIn,
    this.latestShiftClockOut,
    this.propertyAvatars,
    this.shifts,
    this.checkPoints,
  });

  factory InactiveDatum.fromRawJson(String str) =>
      InactiveDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InactiveDatum.fromJson(Map<String, dynamic> json) => InactiveDatum(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyName: json["property_name"],
        type: json["type"],
        assignStaff: json["assign_staff"],
        area: json["area"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        postCode: json["post_code"],
        propertyDescription: json["property_description"],
        location: json["location"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        latestShiftDate:json["latest_shift_date"],
        latestShiftTime:json["latest_shift_time"],
        latestShiftClockIn:json["latest_shift_clock_in"],
        latestShiftClockOut:json["latest_shift_clock_out"],
        propertyAvatars: json["property_avatars"] == null
            ? []
            : List<PropertyAvatar>.from(json["property_avatars"]!
                .map((x) => PropertyAvatar.fromJson(x))),
        shifts: json["shifts"] == null
            ? []
            : List<Shift>.from(json["shifts"]!.map((x) => Shift.fromJson(x))),
        checkPoints: json["check_points"] == null
            ? []
            : List<CheckPoint>.from(
                json["check_points"]!.map((x) => CheckPoint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_name": propertyName,
        "type": type,
        "assign_staff": assignStaff,
        "area": area,
        "country": country,
        "state": state,
        "city": city,
        "post_code": postCode,
        "property_description": propertyDescription,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "property_avatars": propertyAvatars == null
            ? []
            : List<dynamic>.from(propertyAvatars!.map((x) => x.toJson())),
        "shifts": shifts == null
            ? []
            : List<dynamic>.from(shifts!.map((x) => x.toJson())),
        "check_points": checkPoints == null
            ? []
            : List<dynamic>.from(checkPoints!.map((x) => x.toJson())),
      };
}

class CheckPoint {
  int? id;
  int? propertyOwnerId;
  int? propertyId;
  String? propertyName;
  String? checkpointName;
  String? description;
  String? latitude;
  String? longitude;
  String? checkpointQrCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? checkPointTask;

  CheckPoint({
    this.id,
    this.propertyOwnerId,
    this.propertyId,
    this.propertyName,
    this.checkpointName,
    this.description,
    this.latitude,
    this.longitude,
    this.checkpointQrCode,
    this.createdAt,
    this.updatedAt,
    this.checkPointTask,
  });

  factory CheckPoint.fromRawJson(String str) =>
      CheckPoint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckPoint.fromJson(Map<String, dynamic> json) => CheckPoint(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyId: json["property_id"],
        propertyName: json["property_name"],
        checkpointName: json["checkpoint_name"],
        description: json["description"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        checkpointQrCode: json["checkpoint_qr_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        checkPointTask: json["check_point_task"] == null
            ? []
            : List<dynamic>.from(json["check_point_task"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_id": propertyId,
        "property_name": propertyName,
        "checkpoint_name": checkpointName,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
        "checkpoint_qr_code": checkpointQrCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "check_point_task": checkPointTask == null
            ? []
            : List<dynamic>.from(checkPointTask!.map((x) => x)),
      };
}

class PropertyAvatar {
  int? id;
  int? propertyId;
  String? propertyAvatar;

  PropertyAvatar({
    this.id,
    this.propertyId,
    this.propertyAvatar,
  });

  factory PropertyAvatar.fromRawJson(String str) =>
      PropertyAvatar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PropertyAvatar.fromJson(Map<String, dynamic> json) => PropertyAvatar(
        id: json["id"],
        propertyId: json["property_id"],
        propertyAvatar: json["property_avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_id": propertyId,
        "property_avatar": propertyAvatar,
      };
}

class Shift {
  int? id;
  int? propertyOwnerId;
  int? propertyId;
  String? name;
  String? clockIn;
  String? clockInDesc;
  String? clockOut;
  String? clockOutDesc;
  String? qrCodeIn;
  String? qrCodeOut;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Shift({
    this.id,
    this.propertyOwnerId,
    this.propertyId,
    this.name,
    this.clockIn,
    this.clockInDesc,
    this.clockOut,
    this.clockOutDesc,
    this.qrCodeIn,
    this.qrCodeOut,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Shift.fromRawJson(String str) => Shift.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyId: json["property_id"],
        name: json["name"],
        clockIn: json["clock_in"],
        clockInDesc: json["clock_in_desc"],
        clockOut: json["clock_out"],
        clockOutDesc: json["clock_out_desc"],
        qrCodeIn: json["qr_code_in"],
        qrCodeOut: json["qr_code_out"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_id": propertyId,
        "name": name,
        "clock_in": clockIn,
        "clock_in_desc": clockInDesc,
        "clock_out": clockOut,
        "clock_out_desc": clockOutDesc,
        "qr_code_in": qrCodeIn,
        "qr_code_out": qrCodeOut,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
