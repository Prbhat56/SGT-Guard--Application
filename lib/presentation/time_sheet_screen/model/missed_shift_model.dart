// To parse this JSON data, do
//
//     final missedShiftModel = missedShiftModelFromJson(jsonString);

import 'dart:convert';

MissedShiftModel missedShiftModelFromJson(String str) =>
    MissedShiftModel.fromJson(json.decode(str));

String missedShiftModelToJson(MissedShiftModel data) =>
    json.encode(data.toJson());

class MissedShiftModel {
  List<MissedDatum>? data;
  String? propertyImageBaseUrl;
  int? status;

  MissedShiftModel({this.data, this.propertyImageBaseUrl, this.status});

  MissedShiftModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MissedDatum>[];
      json['data'].forEach((v) {
        data!.add(new MissedDatum.fromJson(v));
      });
    }
    propertyImageBaseUrl = json['property_image_base_url'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['property_image_base_url'] = this.propertyImageBaseUrl;
    data['status'] = this.status;
    return data;
  }
}

class MissedDatum {
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
  Shift? shift;
  List<PropertyAvatars>? propertyAvatars = [];

  MissedDatum(
      {this.id,
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
      this.shift,
      this.propertyAvatars});

  MissedDatum.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyOwnerId = json['property_owner_id'];
    propertyName = json['property_name'];
    type = json['type'];
    assignStaff = json['assign_staff'];
    area = json['area'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    postCode = json['post_code'];
    propertyDescription = json['property_description'];
    location = json['location'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    status = json['status'];
    shift = json['shift'] != null ? new Shift.fromJson(json['shift']) : null;

    if (json['property_avatars'] != null) {
      propertyAvatars = <PropertyAvatars>[];
      json['property_avatars'].forEach((v) {
        propertyAvatars!.add(new PropertyAvatars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_owner_id'] = this.propertyOwnerId;
    data['property_name'] = this.propertyName;
    data['type'] = this.type;
    data['assign_staff'] = this.assignStaff;
    data['area'] = this.area;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['post_code'] = this.postCode;
    data['property_description'] = this.propertyDescription;
    data['location'] = this.location;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['status'] = this.status;

    if (this.shift != null) {
      data['shift'] = this.shift!.toJson();
    }
    if (this.propertyAvatars != null) {
      data['property_avatars'] =
          this.propertyAvatars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
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
  String? shiftDate;

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
    this.shiftDate,
  });

  Shift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyOwnerId = json['property_owner_id'];
    propertyId = json['property_id'];
    name = json['name'];
    clockIn = json['clock_in'];
    clockInDesc = json['clock_in_desc'];
    clockOut = json['clock_out'];
    clockOutDesc = json['clock_out_desc'];
    qrCodeIn = json['qr_code_in'];
    qrCodeOut = json['qr_code_out'];
    status = json['status'];
    shiftDate = json["shift_date"] == null ? "" : json["shift_date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_owner_id'] = this.propertyOwnerId;
    data['property_id'] = this.propertyId;
    data['name'] = this.name;
    data['clock_in'] = this.clockIn;
    data['clock_in_desc'] = this.clockInDesc;
    data['clock_out'] = this.clockOut;
    data['clock_out_desc'] = this.clockOutDesc;
    data['qr_code_in'] = this.qrCodeIn;
    data['qr_code_out'] = this.qrCodeOut;
    data['status'] = this.status;
    data['shift_date'] = this.shiftDate;
    return data;
  }
}

class PropertyAvatars {
  int? id;
  int? propertyOwnerId;
  int? propertyId;
  String? propertyAvatar;

  PropertyAvatars({
    this.id,
    this.propertyOwnerId,
    this.propertyId,
    this.propertyAvatar,
  });

  PropertyAvatars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyOwnerId = json['property_owner_id'];
    propertyId = json['property_id'];
    propertyAvatar = json['property_avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_owner_id'] = this.propertyOwnerId;
    data['property_id'] = this.propertyId;
    data['property_avatar'] = this.propertyAvatar;
    return data;
  }
}
