// To parse this JSON data, do
//
//     final checkPointPropertyWise = checkPointPropertyWiseFromJson(jsonString);

import 'dart:convert';

CheckPointPropertyWise checkPointPropertyWiseFromJson(String str) => CheckPointPropertyWise.fromJson(json.decode(str));

String checkPointPropertyWiseToJson(CheckPointPropertyWise data) => json.encode(data.toJson());

class CheckPointPropertyWise {
    Property? property;
    List<Checkpoint>? checkpoints;
    String? imageBaseUrl;
    String? propertyImageBaseUrl;
    int? status;

    CheckPointPropertyWise({
        this.property,
        this.checkpoints,
        this.imageBaseUrl,
        this.propertyImageBaseUrl,
        this.status,
    });

    factory CheckPointPropertyWise.fromJson(Map<String, dynamic> json) => CheckPointPropertyWise(
        property: json["property"] == null ? null : Property.fromJson(json["property"]),
        checkpoints: json["checkpoints"] == null ? [] : List<Checkpoint>.from(json["checkpoints"]!.map((x) => Checkpoint.fromJson(x))),
        imageBaseUrl: json["image_base_url"],
        propertyImageBaseUrl: json["property_image_base_url"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "property": property?.toJson(),
        "checkpoints": checkpoints == null ? [] : List<dynamic>.from(checkpoints!.map((x) => x.toJson())),
        "image_base_url": imageBaseUrl,
        "property_image_base_url": propertyImageBaseUrl,
        "status": status,
    };
}

class Checkpoint {
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
    // List<dynamic>? history;
    List<CheckPointAvatar>? checkPointAvatar;

    Checkpoint({
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
        // this.history,
        this.checkPointAvatar,
    });

    factory Checkpoint.fromJson(Map<String, dynamic> json) => Checkpoint(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyId: json["property_id"],
        propertyName: json["property_name"],
        checkpointName: json["checkpoint_name"],
        description: json["description"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        checkpointQrCode: json["checkpoint_qr_code"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        // history: json["history"] == null ? [] : List<dynamic>.from(json["history"]!.map((x) => x)),
        checkPointAvatar: json["check_point_avatar"] == null ? [] : List<CheckPointAvatar>.from(json["check_point_avatar"]!.map((x) => x)),
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
        // "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x)),
        "check_point_avatar": checkPointAvatar == null ? [] : List<CheckPointAvatar>.from(checkPointAvatar!.map((x) => x)),
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
    Shift? shift;
    String? countryText;
    String? stateText;
    String? cityText;
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
        this.shift,
        this.countryText,
        this.stateText,
        this.cityText,
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
        shift: json["shift"] == null ? null : Shift.fromJson(json["shift"]),
        countryText: json["country_text"],
        stateText: json["state_text"],
        cityText: json["city_text"],
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
        "shift": shift?.toJson(),
        "country_text": countryText,
        "state_text": stateText,
        "city_text": cityText,
        "property_avatars": propertyAvatars == null ? [] : List<dynamic>.from(propertyAvatars!.map((x) => x.toJson())),
    };
}

class PropertyAvatar {
    int? id;
    int? propertyOwnerId;
    int? propertyId;
    String? propertyAvatar;
    DateTime? createdAt;
    DateTime? updatedAt;

    PropertyAvatar({
        this.id,
        this.propertyOwnerId,
        this.propertyId,
        this.propertyAvatar,
        this.createdAt,
        this.updatedAt,
    });

    factory PropertyAvatar.fromJson(Map<String, dynamic> json) => PropertyAvatar(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyId: json["property_id"],
        propertyAvatar: json["property_avatar"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_id": propertyId,
        "property_avatar": propertyAvatar,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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

class CheckPointAvatar {
  int? id;
  int? propertyOwnerId;
  int? propertyId;
  int? checkpointId;
  String? checkpointAvatars;

  CheckPointAvatar({
    this.id,
    this.propertyOwnerId,
    this.propertyId,
    this.checkpointId,
    this.checkpointAvatars,
  });

  factory CheckPointAvatar.fromJson(Map<String, dynamic> json) =>
      CheckPointAvatar(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyId: json["property_id"],
        checkpointId: json["checkpoint_id"],
        checkpointAvatars: json["checkpoint_avatars"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_id": propertyId,
        "checkpoint_id": checkpointId,
        "checkpoint_avatars": checkpointAvatars,
      };
}