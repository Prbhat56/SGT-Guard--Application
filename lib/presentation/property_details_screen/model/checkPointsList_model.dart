// To parse this JSON data, do
//
//     final checkpointsOnProperty = checkpointsOnPropertyFromJson(jsonString);

import 'dart:convert';

CheckpointsOnProperty checkpointsOnPropertyFromJson(String str) => CheckpointsOnProperty.fromJson(json.decode(str));

String checkpointsOnPropertyToJson(CheckpointsOnProperty data) => json.encode(data.toJson());

class CheckpointsOnProperty {
    List<Checkpoint>? checkpoints;
    String? imageBaseUrl;
    String? propertyImageBaseUrl;
    int? status;

    CheckpointsOnProperty({
        this.checkpoints,
        this.imageBaseUrl,
        this.propertyImageBaseUrl,
        this.status,
    });

    factory CheckpointsOnProperty.fromJson(Map<String, dynamic> json) => CheckpointsOnProperty(
        checkpoints: json["checkpoints"] == [] ? [] : List<Checkpoint>.from(json["checkpoints"]!.map((x) => Checkpoint.fromJson(x))),
        imageBaseUrl: json["image_base_url"],
        propertyImageBaseUrl: json["property_image_base_url"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "checkpoints": checkpoints == [] ? [] : List<dynamic>.from(checkpoints!.map((x) => x.toJson())),
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
    String? status;
    dynamic visitAt;
    String? checkInTime;
    String? checkInDate;
    dynamic propertyAvatar;
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
        this.status,
        this.visitAt,
        this.checkInDate,
        this.checkInTime,
        this.propertyAvatar,
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
        status: json["status"],
        visitAt: json["visit_at"],
        checkInTime: json["check_in_time"],
        checkInDate: json["check_in_date"],
        propertyAvatar: json["property_avatar"],
        checkPointAvatar: json["check_point_avatar"] == [] ? [] : List<CheckPointAvatar>.from(json["check_point_avatar"]!.map((x) => CheckPointAvatar.fromJson(x))),
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
        "status": status,
        "visit_at": visitAt,
        "check_in_time": checkInTime,
        "check_in_date": checkInDate,
        "property_avatar": propertyAvatar,
        "check_point_avatar": checkPointAvatar == [] ? [] : List<dynamic>.from(checkPointAvatar!.map((x) => x.toJson())),
    };
}

class CheckPointAvatar {
    int? id;
    int? propertyOwnerId;
    int? propertyId;
    int? checkpointId;
    String? checkpointAvatars;
    DateTime? createdAt;
    DateTime? updatedAt;

    CheckPointAvatar({
        this.id,
        this.propertyOwnerId,
        this.propertyId,
        this.checkpointId,
        this.checkpointAvatars,
        this.createdAt,
        this.updatedAt,
    });

    factory CheckPointAvatar.fromJson(Map<String, dynamic> json) => CheckPointAvatar(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyId: json["property_id"],
        checkpointId: json["checkpoint_id"],
        checkpointAvatars: json["checkpoint_avatars"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_id": propertyId,
        "checkpoint_id": checkpointId,
        "checkpoint_avatars": checkpointAvatars,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
