// To parse this JSON data, do
//
//     final timeSheetDetailsModel = timeSheetDetailsModelFromJson(jsonString);

import 'dart:convert';

TimeSheetDetailsModel timeSheetDetailsModelFromJson(String str) =>
    TimeSheetDetailsModel.fromJson(json.decode(str));

String timeSheetDetailsModelToJson(TimeSheetDetailsModel data) =>
    json.encode(data.toJson());

class TimeSheetDetailsModel {
  TimeSheetData? data;
  String? imageBaseUrl;
  String? propertyImageBaseUrl;
  int? status;

  TimeSheetDetailsModel(
      {this.data, this.imageBaseUrl, this.propertyImageBaseUrl, this.status});

  TimeSheetDetailsModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new TimeSheetData.fromJson(json['data']) : null;
    imageBaseUrl = json['image_base_url'];
    propertyImageBaseUrl = json['property_image_base_url'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['image_base_url'] = this.imageBaseUrl;
    data['property_image_base_url'] = this.propertyImageBaseUrl;
    data['status'] = this.status;
    return data;
  }
}

class TimeSheetData {
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
  List<AssignGuard>? assignGuard = [];
  JobDetails? jobDetails;
  List<Shift>? shifts = [];
  String? countryText;
  String? stateText;
  String? cityText;
  List<PropertyAvatar>? propertyAvatars = [];

  TimeSheetData(
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
      this.assignGuard,
      this.jobDetails,
      this.shifts,
      this.countryText,
      this.stateText,
      this.cityText,
      this.propertyAvatars});

  TimeSheetData.fromJson(Map<String, dynamic> json) {
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
    if (json['assign_guard'] != null) {
      assignGuard = <AssignGuard>[];
      json['assign_guard'].forEach((v) {
        assignGuard!.add(new AssignGuard.fromJson(v));
      });
    }
    jobDetails = json['job_details'] != null
        ? new JobDetails.fromJson(json['job_details'])
        : null;
    if (json['shifts'] != null) {
      shifts = <Shift>[];
      json['shifts'].forEach((v) {
        shifts!.add(new Shift.fromJson(v));
      });
    }
    countryText = json['country_text'];
    stateText = json['state_text'];
    cityText = json['city_text'];
    if (json['property_avatars'] != null) {
      propertyAvatars = <PropertyAvatar>[];
      json['property_avatars'].forEach((v) {
        propertyAvatars!.add(new PropertyAvatar.fromJson(v));
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
    if (this.assignGuard != null) {
      data['assign_guard'] = this.assignGuard!.map((v) => v.toJson()).toList();
    }
    if (this.jobDetails != null) {
      data['job_details'] = this.jobDetails!.toJson();
    }
    if (this.shifts!.length != 0) {
      data['shifts'] = this.shifts!.map((v) => v.toJson()).toList();
    }
    data['country_text'] = this.countryText;
    data['state_text'] = this.stateText;
    data['city_text'] = this.cityText;
    if (this.propertyAvatars != null) {
      data['property_avatars'] =
          this.propertyAvatars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssignGuard {
  int? id;
  int? propertyOwnerId;
  int? routeId;
  int? propertyId;
  int? guardId;
  int? shiftId;
  String? date;
  Details? details;

  AssignGuard({
    this.id,
    this.propertyOwnerId,
    this.routeId,
    this.propertyId,
    this.guardId,
    this.date,
    this.details,
  });

  AssignGuard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyOwnerId = json['property_owner_id'];
    routeId = json['route_id'];
    propertyId = json['property_id'];
    guardId = json['guard_id'];
    shiftId = json['shift_id'];
    date = json["date"] == null ? "" : json["date"];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_owner_id'] = this.propertyOwnerId;
    data['route_id'] = this.routeId;
    data['property_id'] = this.propertyId;
    data['guard_id'] = this.guardId;
    data['shift_id'] = this.shiftId;
    data['date'] = this.date;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
  int? id;
  String? firstName;
  String? lastName;
  String? guardPosition;
  String? shiftCheckIn;
  String? shiftCheckOut;
  int? completedCheckpoint;
  int? remainingCheckpoint;

  Details({
    this.id,
    this.firstName,
    this.lastName,
    this.guardPosition,
    this.shiftCheckIn,
    this.shiftCheckOut,
    this.remainingCheckpoint,
    this.completedCheckpoint,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        guardPosition: json["guard_position"],
        shiftCheckIn: json["shift_check_in"],
        shiftCheckOut: json["shift_check_out"],
        completedCheckpoint:json["completed_checkpoint"],
        remainingCheckpoint:json["remaining_checkpoint"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "guard_position": guardPosition,
        "shift_check_in": shiftCheckIn,
        "shift_check_out": shiftCheckOut,
        "completed_checkpoint":completedCheckpoint,
        "remaining_checkpoint":remainingCheckpoint,
      };
}

class JobDetails {
  String? firstName;
  String? lastName;
  String? guardPosition;
  String? avatar;
  String? shiftTime;
  int? completedCheckpoint;
  int? remainingCheckpoint;

  JobDetails({
    this.firstName,
    this.lastName,
    this.guardPosition,
    this.avatar,
    this.shiftTime,
    this.completedCheckpoint,
    this.remainingCheckpoint,
  });

  JobDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    guardPosition = json['guard_position'];
    avatar = json['avatar'];
    shiftTime = json['shift_time'];
    remainingCheckpoint = json["remaining_checkpoint"];
    completedCheckpoint = json["completed_checkpoint"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['guard_position'] = this.guardPosition;
    data['avatar'] = this.avatar;
    data['shift_time'] = this.shiftTime;
    data['remaining_checkpoint'] = this.remainingCheckpoint;
    data['completed_checkpoint'] = this.completedCheckpoint;
    return data;
  }
}

class PropertyAvatar {
  int? id;
  int? propertyOwnerId;
  int? propertyId;
  String? propertyAvatar;

  PropertyAvatar({
    this.id,
    this.propertyOwnerId,
    this.propertyId,
    this.propertyAvatar,
  });

  factory PropertyAvatar.fromJson(Map<String, dynamic> json) => PropertyAvatar(
        id: json["id"] == null ? "" : json["id"],
        propertyOwnerId:
            json["property_owner_id"] == null ? "" : json["property_owner_id"],
        propertyId: json["property_id"] == null ? "" : json["property_id"],
        propertyAvatar:
            json["property_avatar"] == null ? "" : json["property_avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_id": propertyId,
        "property_avatar": propertyAvatar,
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
  String? date;
  String? dateText;
  GuardDetails? guardDetails;
  String? shiftTime;
  String? propertyName;
  String? actualClockin;
  String? actualClockOut;

  Shift(
      {this.id,
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
      this.date,
      this.dateText,
      this.guardDetails,
      this.shiftTime,
      this.propertyName,
      this.actualClockin,
      this.actualClockOut,});

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
    date = json["date"] == null ? "" : json["date"];
    dateText = json['date_text'];
    guardDetails = json['guard_details'] != null
        ? new GuardDetails.fromJson(json['guard_details'])
        : null;
    shiftTime = json['shift_time'];
    propertyName = json['property_name'];
    actualClockin = json["actual_clockin"];
    actualClockOut = json["actual_clockOut"];
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
    data['date'] = this.date;
    data['date_text'] = this.dateText;
    if (this.guardDetails != null) {
      data['guard_details'] = this.guardDetails!.toJson();
    }
    data['shift_time'] = this.shiftTime;
    data['property_name'] = this.propertyName;
    data["actual_clockin"]= this.actualClockin;
    data["actual_clockOut"]= this.actualClockOut;
    return data;
  }
}

class GuardDetails {
  String? firstName;
  String? lastName;
  String? guardPosition;
  String? avatar;

  GuardDetails(
      {this.firstName, this.lastName, this.guardPosition, this.avatar});

  GuardDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    guardPosition = json['guard_position'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['guard_position'] = this.guardPosition;
    data['avatar'] = this.avatar;
    return data;
  }
}
