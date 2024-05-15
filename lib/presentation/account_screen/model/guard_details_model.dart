import 'dart:convert';

GuardDetails guardDetailsFromJson(String str) => GuardDetails.fromJson(json.decode(str));

String guardDetailsToJson(GuardDetails data) => json.encode(data.toJson());

class GuardDetails {
  UserDetails? userDetails;
  int? status;
  String? imageBaseUrl;

  GuardDetails({
    this.userDetails,
    this.status,
    this.imageBaseUrl,
  });

  factory GuardDetails.fromRawJson(String str) =>
      GuardDetails.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory GuardDetails.fromJson(Map<String, dynamic> json) => GuardDetails(
        userDetails: json["user_details"] == null
            ? null
            : UserDetails.fromJson(json["user_details"]),
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
  String? dateOfBirth;
  String? contactCode;
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
  String? oneSignal;
  // dynamic otp;
  String? backSideIdCard;
  String? frontSideIdCard;
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
    this.oneSignal,
    // this.otp,
    this.backSideIdCard,
    this.frontSideIdCard,
    this.cityText,
    this.stateText,
    this.countryText,
  });

  factory UserDetails.fromRawJson(String str) =>
      UserDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"] ?? 0,
        guardUserId: json["guard_user_id"] ?? "",
        propertyOwnerId: json["property_owner_id"] ?? 0,
        avatar: json["avatar"] ?? "",
        status: json["status"] ?? "",
        isAssign: json["is_assign"] ?? 0,
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        guardPosition: json["guard_position"] ?? "",
        gender: json["gender"] ?? "",
        dateOfBirth: json["date_of_birth"] == null ? "" : json["date_of_birth"],
        contactCode: json["contact_code"] ?? "",
        contactNumber: json["contact_number"] ?? "",
        street: json["street"] ?? "",
        city: json["city"] ?? 0,
        state: json["state"] ?? 0,
        country: json["country"] ?? 0,
        zipCode: json["zip_code"] ?? 0,
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        emailAddress: json["email_address"] ?? "",
        password: json["password"] ?? "",
        apiToken: json["api_token"] ?? "",
        oneSignal: json["one_signal"] ?? "",
        // otp: json["otp"] ?? "",
        backSideIdCard: json["back_side_id_card"] ?? "",
        frontSideIdCard: json["front_side_id_card"] ?? "",
        cityText: json["city_text"] ?? "",
        stateText: json["state_text"] ?? "",
        countryText: json["country_text"] ?? "",
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
        "date_of_birth": dateOfBirth,
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
        "one_signal": oneSignal,
        // "otp": otp,
        "back_side_id_card": backSideIdCard,
        "front_side_id_card": frontSideIdCard,
        "city_text": cityText,
        "state_text": stateText,
        "country_text": countryText,
      };
}
