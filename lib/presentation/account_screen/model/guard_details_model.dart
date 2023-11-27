import 'dart:convert';

class GuardDetails {
    UserDetails? userDetails;
    int? status;
    String? imageBaseUrl;

    GuardDetails({
        this.userDetails,
        this.status,
        this.imageBaseUrl,
    });


    factory GuardDetails.fromRawJson(String str) =>GuardDetails.fromJson(json.decode(str));
    String toRawJson() => json.encode(toJson());

    factory GuardDetails.fromJson(Map<String, dynamic> json) => GuardDetails(
        userDetails: json["user_details"] == null ? null : UserDetails.fromJson(json["user_details"]),
        imageBaseUrl: json["image_base_url"],
        status: json["status"],
      );

    Map<String, dynamic> toJson() => {
        "user_details": userDetails == null ? '' : userDetails,
        "image_base_url": imageBaseUrl,
        "status": status,
      };
}

class UserDetails {
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
    dynamic contactCode;
    String? contactNumber;
    String? street;
    int? city;
    int? state;
    int? country;
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
    String? cityText;
    String? stateText;
    String? countryText;

    UserDetails({
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
        this.cityText,
        this.stateText,
        this.countryText,
    });

    factory UserDetails.fromRawJson(String str) =>
      UserDetails.fromJson(json.decode(str));

        String toRawJson() => json.encode(toJson());

        factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
              id: json["id"],
              guardUserId:json["guard_user_id"],
              propertyOwnerId: json["property_owner_id"],
              avatar:json["avatar"],
              isAssign:json["is_assign"],
              firstName:json["first_name"],
              lastName: json["last_name"],
              guardPosition:json["guard_position"],
              gender:json["gender"],
              dateOfBirth:json["date_of_birth"],
              contactCode: json["contact_code"],
              contactNumber: json["contact_number"],
              street: json["street"],
              city: json["city"],
              state: json["state"],
              country: json["country"],
              zipCode: json["zip_code"],
              latitude: json["latitude"],
              longitude:json["longitude"],
              emailAddress: json["email_address"],
              cityText: json["city_text"],
              stateText: json["state_text"],
              countryText: json["country_text"],
              status: json["status"],
              createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
              updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
            );

  Map<String, dynamic> toJson() => {
        "id": id,
        "guard_user_id":guardUserId,
        "property_owner_id":propertyOwnerId,
        "avatar":avatar,
        "is_assign":isAssign,
        "first_name":firstName,
        "last_name":lastName,
        "guard_position":guardPosition,
        "gender":gender,
        "date_of_birth":dateOfBirth,
        "contact_code":contactCode,
        "contact_number":contactNumber,
        "street":street,
        "city": city,
        "state": state,
        "country": country,
        "zip_code":zipCode,
        "city_text":cityText,
        "state_text":stateText,
        "country_text":countryText,
        "longitude": longitude,
        "latitude": latitude,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
