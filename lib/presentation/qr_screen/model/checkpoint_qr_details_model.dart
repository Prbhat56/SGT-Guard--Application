// To parse this JSON data, do
//
//     final checkpointQrDetails = checkpointQrDetailsFromJson(jsonString);

import 'dart:convert';

CheckpointQrDetails checkpointQrDetailsFromJson(String str) => CheckpointQrDetails.fromJson(json.decode(str));

String checkpointQrDetailsToJson(CheckpointQrDetails data) => json.encode(data.toJson());

class CheckpointQrDetails {
    CheckpointDetails? checkpointDetails;

    CheckpointQrDetails({
        this.checkpointDetails,
    });

    factory CheckpointQrDetails.fromJson(Map<String, dynamic> json) => CheckpointQrDetails(
        checkpointDetails: json["checkpoint_details"] == null ? null : CheckpointDetails.fromJson(json["checkpoint_details"]),
    );

    Map<String, dynamic> toJson() => {
        "checkpoint_details": checkpointDetails?.toJson(),
    };
}

class CheckpointDetails {
    String? propertyName;
    String? checkpointName;
    String? checkpointTask;
    int? checkpointId;
    String? latitude;
    String? longitude;

    CheckpointDetails({
        this.propertyName,
        this.checkpointName,
        this.checkpointTask,
        this.checkpointId,
        this.latitude,
        this.longitude,
    });

    factory CheckpointDetails.fromJson(Map<String, dynamic> json) => CheckpointDetails(
        propertyName: json["property_name"],
        checkpointName: json["checkpoint_name"],
        checkpointTask: json["checkpoint_task"],
        checkpointId: json["checkpoint_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "property_name": propertyName,
        "checkpoint_name": checkpointName,
        "checkpoint_task": checkpointTask,
        "checkpoint_id": checkpointId,
        "latitude": latitude,
        "longitude": longitude,
    };
}
