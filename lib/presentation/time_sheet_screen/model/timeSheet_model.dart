// To parse this JSON data, do
//
//     final timeSheetModel = timeSheetModelFromJson(jsonString);

import 'dart:convert';

TimeSheetModel timeSheetModelFromJson(String str) =>
    TimeSheetModel.fromJson(json.decode(str));

String timeSheetModelToJson(TimeSheetModel data) => json.encode(data.toJson());

class TimeSheetModel {
  List<Completed>? upcomming;
  List<Completed>? completed;
  String? propertyImageBaseUrl;
  int? status;

  TimeSheetModel({
    this.upcomming,
    this.completed,
    this.propertyImageBaseUrl,
    this.status,
  });

  factory TimeSheetModel.fromJson(Map<String, dynamic> json) => TimeSheetModel(
        upcomming: json["upcomming"] == null
            ? []
            : List<Completed>.from(
                json["upcomming"]!.map((x) => Completed.fromJson(x))),
        completed: json["completed"] == null
            ? []
            : List<Completed>.from(
                json["completed"]!.map((x) => Completed.fromJson(x))),
        propertyImageBaseUrl: json["property_image_base_url"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "upcomming": upcomming == null
            ? []
            : List<dynamic>.from(upcomming!.map((x) => x.toJson())),
        "completed": completed == null
            ? []
            : List<dynamic>.from(completed!.map((x) => x.toJson())),
        "property_image_base_url": propertyImageBaseUrl,
        "status": status,
      };
}

class Completed {
  int? id;
  int? propertyOwnerId;
  String? propertyName;
  String? type;
  int? assignStaff;
  String? area;
  int? country;
  int? state;
  int? city;
  String? postCode;
  String? propertyDescription;
  String? location;
  String? longitude;
  String? latitude;
  String? status;
  String? cityText;
  String? stateText;
  String? countryText;
  List<PropertyAvatar>? propertyAvatars;
  List<Shift>? shifts;

  Completed({
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
    this.cityText,
    this.stateText,
    this.countryText,
    this.propertyAvatars,
    this.shifts,
  });

  factory Completed.fromJson(Map<String, dynamic> json) => Completed(
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
        cityText: json["city_text"],
        stateText: json["state_text"],
        countryText: json["country_text"],
        propertyAvatars: json["property_avatars"] == null
            ? []
            : List<PropertyAvatar>.from(json["property_avatars"]!
                .map((x) => PropertyAvatar.fromJson(x))),
        shifts: json["shifts"] == null
            ? []
            : List<Shift>.from(json["shifts"]!.map((x) => Shift.fromJson(x))),
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
        "city_text": cityText,
        "state_text": stateText,
        "country_text": countryText,
        "property_avatars": propertyAvatars == null
            ? []
            : List<dynamic>.from(propertyAvatars!.map((x) => x.toJson())),
        "shifts": shifts == null
            ? []
            : List<dynamic>.from(shifts!.map((x) => x.toJson())),
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
  String? propertyName;
  String? propertyImage;
  String? date;

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
    this.propertyName,
    this.propertyImage,
    this.date,
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
        propertyName: json["property_name"],
        propertyImage:
            json["property_image"] == null ? "" : json["property_image"],
        date: json["date"] == null ? "" : json["date"],
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
        "property_name": propertyName,
        "property_image": propertyImage,
        "date": date,
      };
}
