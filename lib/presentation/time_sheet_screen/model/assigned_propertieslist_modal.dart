// To parse this JSON data, do
//
//     final assignedPropertiesListModal = assignedPropertiesListModalFromJson(jsonString);

import 'dart:convert';

AssignedPropertiesListModal assignedPropertiesListModalFromJson(String str) => AssignedPropertiesListModal.fromJson(json.decode(str));

String assignedPropertiesListModalToJson(AssignedPropertiesListModal data) => json.encode(data.toJson());

class AssignedPropertiesListModal {
    List<AssignedDatum>? data;
    String? propertyImageBaseUrl;
    int? status;

    AssignedPropertiesListModal({
        this.data,
        this.propertyImageBaseUrl,
        this.status,
    });

    factory AssignedPropertiesListModal.fromJson(Map<String, dynamic> json) => AssignedPropertiesListModal(
        data: json["data"] == null ? [] : List<AssignedDatum>.from(json["data"]!.map((x) => AssignedDatum.fromJson(x))),
        propertyImageBaseUrl: json["property_image_base_url"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "property_image_base_url": propertyImageBaseUrl,
        "status": status,
    };
}

class AssignedDatum {
    int? id;
    String? propertyName;
    String? lastReportOn;
    List<PropertyAvatar>? propertyAvatars;

    AssignedDatum({
        this.id,
        this.propertyName,
        this.lastReportOn,
        this.propertyAvatars,
    });

    factory AssignedDatum.fromJson(Map<String, dynamic> json) => AssignedDatum(
        id: json["id"],
        propertyName: json["property_name"],
        lastReportOn: json["last_report_on"],
        propertyAvatars: json["property_avatars"] == null ? [] : List<PropertyAvatar>.from(json["property_avatars"]!.map((x) => PropertyAvatar.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_name": propertyName,
        "last_report_on": lastReportOn,
        "property_avatars": propertyAvatars == null ? [] : List<dynamic>.from(propertyAvatars!.map((x) => x.toJson())),
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
