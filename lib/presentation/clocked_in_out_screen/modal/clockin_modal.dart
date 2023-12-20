// To parse this JSON data, do
//
//     final clockInModal = clockInModalFromJson(jsonString);

import 'dart:convert';

ClockInModal clockInModalFromJson(String str) => ClockInModal.fromJson(json.decode(str));

String clockInModalToJson(ClockInModal data) => json.encode(data.toJson());

class ClockInModal {
    String? message;
    Property? property;
    JobDetails? jobDetails;
    CurrentShift? currentShift;
    String? imageBaseUrl;
    int? status;

    ClockInModal({
        this.message,
        this.property,
        this.jobDetails,
        this.currentShift,
        this.imageBaseUrl,
        this.status,
    });

    factory ClockInModal.fromJson(Map<String, dynamic> json) => ClockInModal(
        message: json["message"],
        property: json["property"] == null ? null : Property.fromJson(json["property"]),
        jobDetails: json["job_details"] == null ? null : JobDetails.fromJson(json["job_details"]),
        currentShift: json["current_shift"] == null ? null : CurrentShift.fromJson(json["current_shift"]),
        imageBaseUrl: json["image_base_url"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "property": property?.toJson(),
        "job_details": jobDetails?.toJson(),
        "current_shift": currentShift?.toJson(),
        "image_base_url": imageBaseUrl,
        "status": status,
    };
}

class CurrentShift {
    int? propertyOwnerId;
    int? guardId;
    int? propertyId;
    String? shiftId;
    DateTime? date;
    DateTime? checkInTime;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;
    String? shiftTime;
    String? shiftDate;

    CurrentShift({
        this.propertyOwnerId,
        this.guardId,
        this.propertyId,
        this.shiftId,
        this.date,
        this.checkInTime,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.shiftTime,
        this.shiftDate,
    });

    factory CurrentShift.fromJson(Map<String, dynamic> json) => CurrentShift(
        propertyOwnerId: json["property_owner_id"],
        guardId: json["guard_id"],
        propertyId: json["property_id"],
        shiftId: json["shift_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        checkInTime: json["check_in_time"] == null ? null : DateTime.parse(json["check_in_time"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
        shiftTime: json["shift_time"],
        shiftDate: json["shift_date"],
    );

    Map<String, dynamic> toJson() => {
        "property_owner_id": propertyOwnerId,
        "guard_id": guardId,
        "property_id": propertyId,
        "shift_id": shiftId,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "check_in_time": checkInTime?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "shift_time": shiftTime,
        "shift_date": shiftDate,
    };
}

class JobDetails {
    int? id;
    String? guardUserId;
    int? propertyOwnerId;
    String? avatar;
    String? status;
    int? isAssign;
    String? firstName;
    String? lastName;
    String? guardPosition;
    String? gender;
    DateTime? dateOfBirth;
    String? contactCode;
    String? contactNumber;
    String? street;
    String? city;
    String? state;
    String? country;
    int? zipCode;
    String? latitude;
    String? longitude;
    String? emailAddress;
    String? password;
    String? apiToken;
    dynamic otp;
    String? backSideIdCard;
    String? frontSideIdCard;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? shiftTime;

    JobDetails({
        this.id,
        this.guardUserId,
        this.propertyOwnerId,
        this.avatar,
        this.status,
        this.isAssign,
        this.firstName,
        this.lastName,
        this.guardPosition,
        this.gender,
        this.dateOfBirth,
        this.contactCode,
        this.contactNumber,
        this.street,
        this.city,
        this.state,
        this.country,
        this.zipCode,
        this.latitude,
        this.longitude,
        this.emailAddress,
        this.password,
        this.apiToken,
        this.otp,
        this.backSideIdCard,
        this.frontSideIdCard,
        this.createdAt,
        this.updatedAt,
        this.shiftTime,
    });

    factory JobDetails.fromJson(Map<String, dynamic> json) => JobDetails(
        id: json["id"],
        guardUserId: json["guard_user_id"],
        propertyOwnerId: json["property_owner_id"],
        avatar: json["avatar"],
        status: json["status"],
        isAssign: json["is_assign"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        guardPosition: json["guard_position"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        contactCode: json["contact_code"],
        contactNumber: json["contact_number"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipCode: json["zip_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        emailAddress: json["email_address"],
        password: json["password"],
        apiToken: json["api_token"],
        otp: json["otp"],
        backSideIdCard: json["back_side_id_card"],
        frontSideIdCard: json["front_side_id_card"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        shiftTime: json["shift_time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "guard_user_id": guardUserId,
        "property_owner_id": propertyOwnerId,
        "avatar": avatar,
        "status": status,
        "is_assign": isAssign,
        "first_name": firstName,
        "last_name": lastName,
        "guard_position": guardPosition,
        "gender": gender,
        "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "contact_code": contactCode,
        "contact_number": contactNumber,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "zip_code": zipCode,
        "latitude": latitude,
        "longitude": longitude,
        "email_address": emailAddress,
        "password": password,
        "api_token": apiToken,
        "otp": otp,
        "back_side_id_card": backSideIdCard,
        "front_side_id_card": frontSideIdCard,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "shift_time": shiftTime,
    };
}

class Property {
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
    DateTime? createdAt;
    DateTime? updatedAt;

    Property({
        this.id,
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
        this.createdAt,
        this.updatedAt,
    });

    factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyName: json["property_name"],
        type: json["type"],
        assignStaff: json["assign_staff"],
        area: json["area"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        postCode: json["post_code"],
        propertyDescription: json["property_description"],
        location: json["location"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_name": propertyName,
        "type": type,
        "assign_staff": assignStaff,
        "area": area,
        "country": country,
        "state": state,
        "city": city,
        "post_code": postCode,
        "property_description": propertyDescription,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
