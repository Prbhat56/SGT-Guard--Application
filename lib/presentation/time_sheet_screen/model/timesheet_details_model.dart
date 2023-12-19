// To parse this JSON data, do
//
//     final timeSheetDetailsModel = timeSheetDetailsModelFromJson(jsonString);

import 'dart:convert';

TimeSheetDetailsModel timeSheetDetailsModelFromJson(String str) =>
    TimeSheetDetailsModel.fromJson(json.decode(str));

String timeSheetDetailsModelToJson(TimeSheetDetailsModel data) =>
    json.encode(data.toJson());

class TimeSheetDetailsModel {
  TimeSheetData? data;
  String? propertyImageBaseUrl;
  int? status;

  TimeSheetDetailsModel({
    this.data,
    this.propertyImageBaseUrl,
    this.status,
  });

  factory TimeSheetDetailsModel.fromJson(Map<String, dynamic> json) =>
      TimeSheetDetailsModel(
        data:
            json["data"] == null ? null : TimeSheetData.fromJson(json["data"]),
        propertyImageBaseUrl: json["property_image_base_url"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "property_image_base_url": propertyImageBaseUrl,
        "status": status,
      };
}

class TimeSheetData {
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
  List<Shift>? shifts;
  String? countryText;
  String? stateText;
  String? cityText;
  List<PropertyAvatar>? propertyAvatars;
  List<AssignGuard>? assignGuard;

  TimeSheetData({
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
    this.shifts,
    this.countryText,
    this.stateText,
    this.cityText,
    this.propertyAvatars,
    this.assignGuard,
  });

  factory TimeSheetData.fromJson(Map<String, dynamic> json) => TimeSheetData(
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
        shifts: json["shifts"] == null
            ? []
            : List<Shift>.from(json["shifts"]!.map((x) => Shift.fromJson(x))),
        countryText: json["country_text"],
        stateText: json["state_text"],
        cityText: json["city_text"],
        propertyAvatars: json["property_avatars"] == null
            ? []
            : List<PropertyAvatar>.from(json["property_avatars"]!
                .map((x) => PropertyAvatar.fromJson(x))),
        assignGuard: json["assign_guard"] == null
            ? []
            : List<AssignGuard>.from(
                json["assign_guard"]!.map((x) => AssignGuard.fromJson(x))),
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
        "shifts": shifts == null
            ? []
            : List<dynamic>.from(shifts!.map((x) => x.toJson())),
        "country_text": countryText,
        "state_text": stateText,
        "city_text": cityText,
        "property_avatars": propertyAvatars == null
            ? []
            : List<dynamic>.from(propertyAvatars!.map((x) => x.toJson())),
        "assign_guard": assignGuard == null
            ? []
            : List<dynamic>.from(assignGuard!.map((x) => x.toJson())),
      };
}

class AssignGuard {
  int? id;
  int? propertyOwnerId;
  int? routeId;
  int? propertyId;
  int? guardId;
  String? date;
  Details? details;

  AssignGuard({
    this.id,
    this.propertyOwnerId,
    this.routeId,
    this.propertyId,
    this.guardId,
    this.date,
    this.details,
  });

  factory AssignGuard.fromJson(Map<String, dynamic> json) => AssignGuard(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        routeId: json["route_id"],
        propertyId: json["property_id"],
        guardId: json["guard_id"],
        date: json["date"] == null ? "" : json["date"],
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "route_id": routeId,
        "property_id": propertyId,
        "guard_id": guardId,
        "date": date,
        "details": details?.toJson(),
      };
}

class Details {
  int? id;
  String? firstName;
  String? lastName;
  String? guardPosition;
  String? shiftCheckIn;
  String? shiftCheckOut;

  Details({
    this.id,
    this.firstName,
    this.lastName,
    this.guardPosition,
    this.shiftCheckIn,
    this.shiftCheckOut,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        guardPosition: json["guard_position"],
        shiftCheckIn: json["shift_check_in"],
        shiftCheckOut: json["shift_check_out"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "guard_position": guardPosition,
        "shift_check_in": shiftCheckIn,
        "shift_check_out": shiftCheckOut,
      };
}

class PropertyAvatar {
  int? id;
  int? propertyOwnerId;
  int? propertyId;
  String? propertyAvatar;

  PropertyAvatar({
    this.id,
    this.propertyOwnerId,
    this.propertyId,
    this.propertyAvatar,
  });

  factory PropertyAvatar.fromJson(Map<String, dynamic> json) => PropertyAvatar(
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
      };
}
