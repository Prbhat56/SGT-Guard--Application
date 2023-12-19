// To parse this JSON data, do
//
//     final checkPointDetailsModal = checkPointDetailsModalFromJson(jsonString);

import 'dart:convert';

CheckPointDetailsModal checkPointDetailsModalFromJson(String str) => CheckPointDetailsModal.fromJson(json.decode(str));

String checkPointDetailsModalToJson(CheckPointDetailsModal data) => json.encode(data.toJson());

class CheckPointDetailsModal {
    Data? data;
    String? imageBaseUrl;
    int? status;

    CheckPointDetailsModal({
        this.data,
        this.imageBaseUrl,
        this.status,
    });

    factory CheckPointDetailsModal.fromJson(Map<String, dynamic> json) => CheckPointDetailsModal(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        imageBaseUrl: json["image_base_url"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "image_base_url": imageBaseUrl,
        "status": status,
    };
}

class Data {
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
    List<CheckPointTask>? checkPointTask;

    Data({
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        checkPointTask: json["check_point_task"] == null ? [] : List<CheckPointTask>.from(json["check_point_task"]!.map((x) => CheckPointTask.fromJson(x))),
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
        "check_point_task": checkPointTask == null ? [] : List<dynamic>.from(checkPointTask!.map((x) => x.toJson())),
    };
}

class CheckPointTask {
    int? id;
    int? propertyOwnerId;
    int? propertyId;
    int? checkpointId;
    String? checkpointTasks;
    String? status;
    String? remarks;
    String? images;
    DateTime? createdAt;
    DateTime? updatedAt;

    CheckPointTask({
        this.id,
        this.propertyOwnerId,
        this.propertyId,
        this.checkpointId,
        this.checkpointTasks,
        this.status,
        this.remarks,
        this.images,
        this.createdAt,
        this.updatedAt,
    });

    factory CheckPointTask.fromJson(Map<String, dynamic> json) => CheckPointTask(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyId: json["property_id"],
        checkpointId: json["checkpoint_id"],
        checkpointTasks: json["checkpoint_tasks"],
        status: json["status"],
        remarks: json["remarks"],
        images: json["images"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_id": propertyId,
        "checkpoint_id": checkpointId,
        "checkpoint_tasks": checkpointTasks,
        "status": status,
        "remarks": remarks,
        "images": images,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
