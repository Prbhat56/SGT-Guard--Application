// To parse this JSON data, do
//
//     final reportListModel = reportListModelFromJson(jsonString);

import 'dart:convert';

ReportListModel reportListModelFromJson(String str) => ReportListModel.fromJson(json.decode(str));

String reportListModelToJson(ReportListModel data) => json.encode(data.toJson());

class ReportListModel {
    List<ActiveResponseData>? data;
    String? propertyImageBaseUrl;
    int? status;

    ReportListModel({
        this.data,
        this.propertyImageBaseUrl,
        this.status,
    });

    factory ReportListModel.fromJson(Map<String, dynamic> json) => ReportListModel(
        data: json["data"] == null ? [] : List<ActiveResponseData>.from(json["data"]!.map((x) => ActiveResponseData.fromJson(x))),
        propertyImageBaseUrl: json["property_image_base_url"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "property_image_base_url": propertyImageBaseUrl,
        "status": status,
    };
}

class ActiveResponseData {
    int? id;
    String? propertyName;
    String? country;
    String? state;
    String? city;
    String? postCode;
    String? location;
    String? longitude;
    String? latitude;
    String? countryTitle;
    String? stateTitle;
    String? cityTitle;
    List<PropertyAvatar>? propertyAvatars;
    List<Shift>? shifts;

    ActiveResponseData({
        this.id,
        this.propertyName,
        this.country,
        this.state,
        this.city,
        this.postCode,
        this.location,
        this.longitude,
        this.latitude,
        this.countryTitle,
        this.stateTitle,
        this.cityTitle,
        this.propertyAvatars,
        this.shifts,
    });

    factory ActiveResponseData.fromJson(Map<String, dynamic> json) => ActiveResponseData(
        id: json["id"],
        propertyName: json["property_name"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        postCode: json["post_code"],
        location: json["location"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        countryTitle: json["country_title"],
        stateTitle: json["state_title"],
        cityTitle: json["city_title"],
        propertyAvatars: json["property_avatars"] == null ? [] : List<PropertyAvatar>.from(json["property_avatars"]!.map((x) => PropertyAvatar.fromJson(x))),
        shifts: json["shifts"] == null ? [] : List<Shift>.from(json["shifts"]!.map((x) => Shift.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_name": propertyName,
        "country": country,
        "state": state,
        "city": city,
        "post_code": postCode,
        "location": location,
        "longitude": longitude,
        "latitude": latitude,
        "country_title": countryTitle,
        "state_title": stateTitle,
        "city_title": cityTitle,
        "property_avatars": propertyAvatars == null ? [] : List<dynamic>.from(propertyAvatars!.map((x) => x.toJson())),
        "shifts": shifts == null ? [] : List<dynamic>.from(shifts!.map((x) => x.toJson())),
    };
}

class PropertyAvatar {
    int? id;
    int? propertyId;
    String? propertyAvatar;

    PropertyAvatar({
        this.id,
        this.propertyId,
        this.propertyAvatar,
    });

    factory PropertyAvatar.fromJson(Map<String, dynamic> json) => PropertyAvatar(
        id: json["id"],
        propertyId: json["property_id"],
        propertyAvatar: json["property_avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_id": propertyId,
        "property_avatar": propertyAvatar,
    };
}

class Shift {
    int? id;
    int? propertyId;
    String? clockIn;

    Shift({
        this.id,
        this.propertyId,
        this.clockIn,
    });

    factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["id"],
        propertyId: json["property_id"],
        clockIn: json["clock_in"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_id": propertyId,
        "clock_in": clockIn,
    };
}
