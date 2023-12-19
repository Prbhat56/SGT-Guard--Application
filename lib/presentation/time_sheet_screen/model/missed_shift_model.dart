// To parse this JSON data, do
//
//     final missedShiftModel = missedShiftModelFromJson(jsonString);

import 'dart:convert';

MissedShiftModel missedShiftModelFromJson(String str) =>
    MissedShiftModel.fromJson(json.decode(str));

String missedShiftModelToJson(MissedShiftModel data) =>
    json.encode(data.toJson());

class MissedShiftModel {
  List<MissedDatum>? data;
  String? propertyImageBaseUrl;
  int? status;

  MissedShiftModel({
    this.data,
    this.propertyImageBaseUrl,
    this.status,
  });

  factory MissedShiftModel.fromJson(Map<String, dynamic> json) =>
      MissedShiftModel(
        data: json["data"] == null
            ? []
            : List<MissedDatum>.from(
                json["data"]!.map((x) => MissedDatum.fromJson(x))),
        propertyImageBaseUrl: json["property_image_base_url"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "property_image_base_url": propertyImageBaseUrl,
        "status": status,
      };
}

class MissedDatum {
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
  Shift? shift;
  List<PropertyAvatarElement>? propertyAvatars;

  MissedDatum({
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
    this.shift,
    this.propertyAvatars,
  });

  factory MissedDatum.fromJson(Map<String, dynamic> json) => MissedDatum(
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
        shift: json["shift"] == null ? null : Shift.fromJson(json["shift"]),
        propertyAvatars: json["property_avatars"] == null
            ? []
            : List<PropertyAvatarElement>.from(json["property_avatars"]!
                .map((x) => PropertyAvatarElement.fromJson(x))),
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
        "shift": shift?.toJson(),
        "property_avatars": propertyAvatars == null
            ? []
            : List<dynamic>.from(propertyAvatars!.map((x) => x.toJson())),
      };
}

class PropertyAvatarElement {
  int? id;
  int? propertyOwnerId;
  int? propertyId;
  String? propertyAvatar;

  PropertyAvatarElement({
    this.id,
    this.propertyOwnerId,
    this.propertyId,
    this.propertyAvatar,
  });

  factory PropertyAvatarElement.fromJson(Map<String, dynamic> json) =>
      PropertyAvatarElement(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyId: json["property_id"],
        propertyAvatar: json["property_avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
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
  String? shiftDate;

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
    this.shiftDate,
  });

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
        shiftDate: json["shift_date"] == null ? "" : json["shift_date"],
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
        "shift_date": shiftDate,
      };
}
