import 'dart:convert';

class TimeSheetModel {
    List<Upcomming>? upcomming;
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
        upcomming: json["upcomming"] == null ? [] : List<Upcomming>.from(
                json["shifts"]!.map((x) => Shift.fromJson(x))),
        completed: json["completed"] == null ? [] : List<Completed>.from(
                json["shifts"]!.map((x) => Shift.fromJson(x))),
        propertyImageBaseUrl:json["property_image_base_url"],
        status: json["status"],
      );

}

class Completed {
    int? id;
    int? propertyOwnerId;
    PropertyName? propertyName;
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
        this.createdAt,
        this.updatedAt,
        this.propertyAvatars,
        this.shifts,
    });

}

class Upcomming {
    int? id;
    int? propertyOwnerId;
    PropertyName? propertyName;
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
    List<PropertyAvatar>? propertyAvatars;
    List<Shift>? shifts;

    Upcomming({
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
        this.propertyAvatars,
        this.shifts,
    });

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

}

enum PropertyName {
    JK_VILLA,
    RIVI_PROPERTIES
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
    PropertyName? propertyName;
    String? propertyImage;
    DateTime? date;

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
        this.propertyName,
        this.propertyImage,
        this.date,
    });

    factory Shift.fromRawJson(String str) =>
      Shift.fromJson(json.decode(str));

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
        createdAt:json["created_at"],
        updatedAt:json["updated_at"],
        propertyName:json["property_name"],
        propertyImage:json["property_image"],
        status: json["status"],
      );

      Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_id": propertyId,
        "name": name,
        "clock_in": clockIn,
        "clock_in_desc":clockInDesc,
        "clock_out":clockOut,
        "clock_out_desc":clockOutDesc,
        "qr_code_in":qrCodeIn,
        "qr_code_out":qrCodeOut,
        "created_at":createdAt,
        "updated_at":updatedAt,
        "property_name":propertyName,
        "property_image":propertyImage,
        "status": status,
      };
}
