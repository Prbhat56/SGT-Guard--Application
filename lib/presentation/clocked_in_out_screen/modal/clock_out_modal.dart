// To parse this JSON data, do
//
//     final clockOutModal = clockOutModalFromJson(jsonString);

import 'dart:convert';

ClockOutModal clockOutModalFromJson(String str) => ClockOutModal.fromJson(json.decode(str));

String clockOutModalToJson(ClockOutModal data) => json.encode(data.toJson());

class ClockOutModal {
    String? message;
    int? status;

    ClockOutModal({
        this.message,
        this.status,
    });

    factory ClockOutModal.fromJson(Map<String, dynamic> json) => ClockOutModal(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
