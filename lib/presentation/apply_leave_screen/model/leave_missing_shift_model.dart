// To parse this JSON data, do
//
//     final leaveApplyMissingShiftsModel = leaveApplyMissingShiftsModelFromJson(jsonString);

import 'dart:convert';

LeaveApplyMissingShiftsModel leaveApplyMissingShiftsModelFromJson(String str) => LeaveApplyMissingShiftsModel.fromJson(json.decode(str));

String leaveApplyMissingShiftsModelToJson(LeaveApplyMissingShiftsModel data) => json.encode(data.toJson());

class LeaveApplyMissingShiftsModel {
    List<Response>? response;
    String? imageBaseUrl;
    int? status;

    LeaveApplyMissingShiftsModel({
        this.response,
        this.imageBaseUrl,
        this.status,
    });

    factory LeaveApplyMissingShiftsModel.fromJson(Map<String, dynamic> json) => LeaveApplyMissingShiftsModel(
        response: json["response"] == null ? [] : List<Response>.from(json["response"]!.map((x) => Response.fromJson(x))),
        imageBaseUrl: json["image_base_url"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "response": response == null ? [] : List<dynamic>.from(response!.map((x) => x.toJson())),
        "image_base_url": imageBaseUrl,
        "status": status,
    };
}

class Response {
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
    Property? property;

    Response({
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
        this.property,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        property: json["property"] == null ? null : Property.fromJson(json["property"]),
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
        "property": property?.toJson(),
    };
}

class Property {
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
    List<PropertyAvatar>? propertyAvatars;

    Property({
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
    });

    factory Property.fromJson(Map<String, dynamic> json) => Property(
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        propertyAvatars: json["property_avatars"] == null ? [] : List<PropertyAvatar>.from(json["property_avatars"]!.map((x) => PropertyAvatar.fromJson(x))),
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
        "property_avatars": propertyAvatars == null ? [] : List<dynamic>.from(propertyAvatars!.map((x) => x.toJson())),
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
