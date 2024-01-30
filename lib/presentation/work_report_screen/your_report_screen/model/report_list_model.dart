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
  String? imageBaseUrl;

  ReportListModel({this.response, this.count, this.status, this.imageBaseUrl});

  ReportListModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <ReportResponse>[];
      json['response'].forEach((v) {
        response!.add(new ReportResponse.fromJson(v));
      });
    }
    count = json['count'] != null ? new Count.fromJson(json['count']) : null;
    imageBaseUrl =
    json["image_base_url"];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    if (this.count != null) {
      data['count'] = this.count!.toJson();
    }
    data['image_base_url'] = this.imageBaseUrl;
    data['status'] = this.status;
    return data;
  }
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
  List<String>? images = [];
  String? latitude;
  String? longitude;
  String? actionTaken;
  String? officerName;
  String? officerDesignation;
  // String? peopleInvolvedName;
  // String? peopleInvolvedPhone;
  // String? witnessesName;
  // String? witnessesPhone;

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
    this.latitude,
    this.longitude,
    this.actionTaken,
    this.officerName,
    this.officerDesignation,
    // this.peopleInvolvedName,
    // this.peopleInvolvedPhone,
    // this.witnessesName,
    // this.witnessesPhone,
  });

  ReportResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyOwnerId = json['property_owner_id'];
    propertyId = json['property_id'];
    guardId = json['guard_id'];
    reportType = json["report_type"] == null ? "" : json["report_type"];
    subject = json["subject"] == null ? "" : json["subject"];
    notes = json["notes"] == null ? "" : json["notes"];
    vehicleManufacturer = json['vehicle_manufacturer'] == null
        ? ""
        : json["vehicle_manufacturer"];
    model = json['model'] == null ? "" : json["model"];
    color = json['color'] == null ? "" : json["color"];
    licenseNumber =
        json['license_number'] == null ? "" : json["license_number"];
    state = json['state'] == null ? "" : json["state"];
    towed = json['towed'] == null ? "" : json["towed"];
    emergencyDate =
        json["emergency_date"] == null ? "" : json["emergency_date"];
    emergencyTime =
        json["emergency_time"] == null ? "" : json["emergency_time"];
    emergencyDetails =
        json['emergency_details'] == null ? "" : json["emergency_details"];
    images = json["images"] == null
        ? []
        : List<String>.from(json["images"]!.map((x) => x));
    latitude = json["latitude"] == null ? "" : json["latitude"];
    longitude = json["longitude"] == null ? "" : json["longitude"];
    actionTaken = json['action_taken'] == null ? "" : json["action_taken"];
    officerName = json['officer_name'] == null ? "" : json["officer_name"];
    officerDesignation =
        json['officer_designation'] == null ? "" : json["officer_designation"];
    // peopleInvolvedName = json['people_involved_name'] == null
    //     ? ""
    //     : json["people_involved_name"];
    // peopleInvolvedPhone = json['people_involved_phone'] == null
    //     ? ""
    //     : json["people_involved_phone"];
    // witnessesName =
    //     json['witnesses_name'] == null ? "" : json["witnesses_name"];
    // witnessesPhone =
    //     json['witnesses_phone'] == null ? "" : json["witnesses_phone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_owner_id'] = this.propertyOwnerId;
    data['property_id'] = this.propertyId;
    data['guard_id'] = this.guardId;
    data['report_type'] = this.reportType;
    data['subject'] = this.subject;
    data['notes'] = this.notes;
    data['vehicle_manufacturer'] = this.vehicleManufacturer;
    data['model'] = this.model;
    data['color'] = this.color;
    data['license_number'] = this.licenseNumber;
    data['state'] = this.state;
    data['towed'] = this.towed;
    data['emergency_date'] = this.emergencyDate;
    data['emergency_time'] = this.emergencyTime;
    data['emergency_details'] = this.emergencyDetails;
    data['images'] = this.images;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['action_taken'] = this.actionTaken;
    data['officer_name'] = this.officerName;
    data['officer_designation'] = this.officerDesignation;
    // data['people_involved_name'] = this.peopleInvolvedName;
    // data['people_involved_phone'] = this.peopleInvolvedPhone;
    // data['witnesses_name'] = this.witnessesName;
    // data['witnesses_phone'] = this.witnessesPhone;
    return data;
  }
}

class Count {
  int? general;
  int? maintenance;
  int? parking;
  int? emergency;

  Count({this.general, this.maintenance, this.parking, this.emergency});

  Count.fromJson(Map<String, dynamic> json) {
    general = json['general'];
    maintenance = json['maintenance'];
    parking = json['parking'];
    emergency = json['emergency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['general'] = this.general;
    data['maintenance'] = this.maintenance;
    data['parking'] = this.parking;
    data['emergency'] = this.emergency;
    return data;
  }
}
