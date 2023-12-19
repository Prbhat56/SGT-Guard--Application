// To parse this JSON data, do
//
//     final reportListModel = reportListModelFromJson(jsonString);

import 'dart:convert';

ReportListModel reportListModelFromJson(String str) =>
    ReportListModel.fromJson(json.decode(str));

String reportListModelToJson(ReportListModel data) =>
    json.encode(data.toJson());

class ReportListModel {
  List<ReportResponse>? response;
  Count? count;
  int? status;

  ReportListModel({
    this.response,
    this.count,
    this.status,
  });

  factory ReportListModel.fromJson(Map<String, dynamic> json) =>
      ReportListModel(
        response: json["response"] == null
            ? []
            : List<ReportResponse>.from(
                json["response"]!.map((x) => ReportResponse.fromJson(x))),
        count: json["count"] == null ? null : Count.fromJson(json["count"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "response": response == null
            ? []
            : List<dynamic>.from(response!.map((x) => x.toJson())),
        "count": count?.toJson(),
        "status": status,
      };
}

class Count {
  int? general;
  int? maintenance;
  int? parking;
  int? emergency;

  Count({
    this.general,
    this.maintenance,
    this.parking,
    this.emergency,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        general: json["general"],
        maintenance: json["maintenance"],
        parking: json["parking"],
        emergency: json["emergency"],
      );

  Map<String, dynamic> toJson() => {
        "general": general,
        "maintenance": maintenance,
        "parking": parking,
        "emergency": emergency,
      };
}

class ReportResponse {
  int? id;
  int? propertyOwnerId;
  int? propertyId;
  int? guardId;
  String? reportType;
  String? subject;
  String? notes;
  String? vehicleManufacturer;
  String? model;
  String? color;
  String? licenseNumber;
  String? state;
  String? towed;
  String? emergencyDate;
  String? emergencyTime;
  String? emergencyDetails;
  dynamic images;
  dynamic videos;
  String? latitude;
  String? longitude;
  String? actionTaken;
  dynamic policeReport;
  String? officerName;
  String? officerDesignation;
  String? peopleInvolvedName;
  String? peopleInvolvedPhone;
  String? witnessesName;
  String? witnessesPhone;

  ReportResponse({
    this.id,
    this.propertyOwnerId,
    this.propertyId,
    this.guardId,
    this.reportType,
    this.subject,
    this.notes,
    this.vehicleManufacturer,
    this.model,
    this.color,
    this.licenseNumber,
    this.state,
    this.towed,
    this.emergencyDate,
    this.emergencyTime,
    this.emergencyDetails,
    this.images,
    this.videos,
    this.latitude,
    this.longitude,
    this.actionTaken,
    this.policeReport,
    this.officerName,
    this.officerDesignation,
    this.peopleInvolvedName,
    this.peopleInvolvedPhone,
    this.witnessesName,
    this.witnessesPhone,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) => ReportResponse(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyId: json["property_id"],
        guardId: json["guard_id"],
        reportType: json["report_type"],
        subject: json["subject"],
        notes: json["notes"],
        vehicleManufacturer: json["vehicle_manufacturer"],
        model: json["model"],
        color: json["color"],
        licenseNumber: json["license_number"],
        state: json["state"],
        towed: json["towed"],
        emergencyDate: json["emergency_date"] == null ? null : "",
        emergencyTime: json["emergency_time"],
        emergencyDetails: json["emergency_details"],
        images: json["images"],
        videos: json["videos"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        actionTaken: json["action_taken"],
        policeReport: json["police_report"],
        officerName: json["officer_name"],
        officerDesignation: json["officer_designation"],
        peopleInvolvedName: json["people_involved_name"],
        peopleInvolvedPhone: json["people_involved_phone"],
        witnessesName: json["witnesses_name"],
        witnessesPhone: json["witnesses_phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_id": propertyId,
        "guard_id": guardId,
        "report_type": reportType,
        "subject": subject,
        "notes": notes,
        "vehicle_manufacturer": vehicleManufacturer,
        "model": model,
        "color": color,
        "license_number": licenseNumber,
        "state": state,
        "towed": towed,
        "emergency_date": emergencyDate,
        "emergency_time": emergencyTime,
        "emergency_details": emergencyDetails,
        "images": images,
        "videos": videos,
        "latitude": latitude,
        "longitude": longitude,
        "action_taken": actionTaken,
        "police_report": policeReport,
        "officer_name": officerName,
        "officer_designation": officerDesignation,
        "people_involved_name": peopleInvolvedName,
        "people_involved_phone": peopleInvolvedPhone,
        "witnesses_name": witnessesName,
        "witnesses_phone": witnessesPhone,
      };
}
