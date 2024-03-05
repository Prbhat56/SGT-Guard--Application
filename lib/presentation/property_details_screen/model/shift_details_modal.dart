// To parse this JSON data, do
//
//     final shiftDetailsModal = shiftDetailsModalFromJson(jsonString);

import 'dart:convert';

ShiftDetailsModal shiftDetailsModalFromJson(String str) => ShiftDetailsModal.fromJson(json.decode(str));

String shiftDetailsModalToJson(ShiftDetailsModal data) => json.encode(data.toJson());

class ShiftDetailsModal {
    ShiftDetails? shiftDetails;

    ShiftDetailsModal({
        this.shiftDetails,
    });

    factory ShiftDetailsModal.fromJson(Map<String, dynamic> json) => ShiftDetailsModal(
        shiftDetails: json["shift_details"] == null ? null : ShiftDetails.fromJson(json["shift_details"]),
    );

    Map<String, dynamic> toJson() => {
        "shift_details": shiftDetails?.toJson(),
    };
}

class ShiftDetails {
    String? shiftName;
    String? clockIn;
    String? clockOut;
    String? description;
    int? shiftId;

    ShiftDetails({
        this.shiftName,
        this.clockIn,
        this.clockOut,
        this.description,
        this.shiftId,
    });

    factory ShiftDetails.fromJson(Map<String, dynamic> json) => ShiftDetails(
        shiftName: json["shift_name"],
        clockIn: json["clock_in"],
        clockOut: json["clock_out"],
        description: json["Description"],
        shiftId: json["shift_id"],
    );

    Map<String, dynamic> toJson() => {
        "shift_name": shiftName,
        "clock_in": clockIn,
        "clock_out":clockOut,
        "Description": description,
        "shift_id": shiftId,
    };
}
