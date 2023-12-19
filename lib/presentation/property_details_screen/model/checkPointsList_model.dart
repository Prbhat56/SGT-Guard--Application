// To parse this JSON data, do
//
//     final checkPointsModal = checkPointsModalFromJson(jsonString);

import 'dart:convert';

CheckPointsModal checkPointsModalFromJson(String str) => CheckPointsModal.fromJson(json.decode(str));

String checkPointsModalToJson(CheckPointsModal data) => json.encode(data.toJson());

class CheckPointsModal {
    List<Checkpoint>? checkpoints;
    String? imageBaseUrl;
    int? status;

    CheckPointsModal({
        this.checkpoints,
        this.imageBaseUrl,
        this.status,
    });

    factory CheckPointsModal.fromJson(Map<String, dynamic> json) => CheckPointsModal(
        checkpoints: json["checkpoints"] == null ? [] : List<Checkpoint>.from(json["checkpoints"]!.map((x) => Checkpoint.fromJson(x))),
        imageBaseUrl: json["image_base_url"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "checkpoints": checkpoints == null ? [] : List<dynamic>.from(checkpoints!.map((x) => x.toJson())),
        "image_base_url": imageBaseUrl,
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
    List<dynamic>? checkPointAvatar;

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
        checkPointAvatar: json["check_point_avatar"] == null ? [] : List<dynamic>.from(json["check_point_avatar"]!.map((x) => x)),
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
        "check_point_avatar": checkPointAvatar == null ? [] : List<dynamic>.from(checkPointAvatar!.map((x) => x)),
    };
}
