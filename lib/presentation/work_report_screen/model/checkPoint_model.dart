// // To parse this JSON data, do
// //
// //     final checkPointDetailsModal = checkPointDetailsModalFromJson(jsonString);

// import 'dart:convert';

// CheckPointDetailsModal checkPointDetailsModalFromJson(String str) => CheckPointDetailsModal.fromJson(json.decode(str));

// String checkPointDetailsModalToJson(CheckPointDetailsModal data) => json.encode(data.toJson());

// class CheckPointDetailsModal {
//     Data? data;
//     String? imageBaseUrl;
//     String? propertyImageBaseUrl;
//     int? status;

//     CheckPointDetailsModal({
//         this.data,
//         this.imageBaseUrl,
//         this.propertyImageBaseUrl,
//         this.status,
//     });

//     factory CheckPointDetailsModal.fromJson(Map<String, dynamic> json) => CheckPointDetailsModal(
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//         imageBaseUrl: json["image_base_url"],
//         propertyImageBaseUrl: json["property_image_base_url"],
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "data": data?.toJson(),
//         "image_base_url": imageBaseUrl,
//         "property_image_base_url": propertyImageBaseUrl,
//         "status": status,
//     };
// }

// class Data {
//     int? id;
//     int? propertyOwnerId;
//     int? propertyId;
//     String? propertyName;
//     String? checkpointName;
//     String? description;
//     String? latitude;
//     String? longitude;
//     String? checkpointQrCode;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     String? taskRemarks;
//     List<String>? taskImages;
//     List<CheckPointTask>? checkPointTask;
//     Property? property;

//     Data({
//         this.id,
//         this.propertyOwnerId,
//         this.propertyId,
//         this.propertyName,
//         this.checkpointName,
//         this.description,
//         this.latitude,
//         this.longitude,
//         this.checkpointQrCode,
//         this.createdAt,
//         this.updatedAt,
//         this.taskRemarks,
//         this.taskImages,
//         this.checkPointTask,
//         this.property,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"],
//         propertyOwnerId: json["property_owner_id"],
//         propertyId: json["property_id"],
//         propertyName: json["property_name"],
//         checkpointName: json["checkpoint_name"],
//         description: json["description"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         checkpointQrCode: json["checkpoint_qr_code"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         taskRemarks: json["task_remarks"],
//         taskImages: json["task_images"] == null ? [] : List<String>.from(json["task_images"]!.map((x) => x)),
//         checkPointTask: json["check_point_task"] == null ? [] : List<CheckPointTask>.from(json["check_point_task"]!.map((x) => CheckPointTask.fromJson(x))),
//         property: json["property"] == null ? null : Property.fromJson(json["property"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "property_owner_id": propertyOwnerId,
//         "property_id": propertyId,
//         "property_name": propertyName,
//         "checkpoint_name": checkpointName,
//         "description": description,
//         "latitude": latitude,
//         "longitude": longitude,
//         "checkpoint_qr_code": checkpointQrCode,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "task_remarks": taskRemarks,
//         "task_images": taskImages == null ? [] : List<dynamic>.from(taskImages!.map((x) => x)),
//         "check_point_task": checkPointTask == null ? [] : List<dynamic>.from(checkPointTask!.map((x) => x.toJson())),
//         "property": property?.toJson(),
//     };
// }

// class CheckPointTask {
//     int? id;
//     int? propertyOwnerId;
//     int? propertyId;
//     int? checkpointId;
//     String? checkpointTasks;
//     String? status;
//     String? remarks;
//     String? images;
//     DateTime? createdAt;
//     DateTime? updatedAt;

//     CheckPointTask({
//         this.id,
//         this.propertyOwnerId,
//         this.propertyId,
//         this.checkpointId,
//         this.checkpointTasks,
//         this.status,
//         this.remarks,
//         this.images,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory CheckPointTask.fromJson(Map<String, dynamic> json) => CheckPointTask(
//         id: json["id"],
//         propertyOwnerId: json["property_owner_id"],
//         propertyId: json["property_id"],
//         checkpointId: json["checkpoint_id"],
//         checkpointTasks: json["checkpoint_tasks"],
//         status: json["status"],
//         remarks: json["remarks"],
//         images: json["images"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "property_owner_id": propertyOwnerId,
//         "property_id": propertyId,
//         "checkpoint_id": checkpointId,
//         "checkpoint_tasks": checkpointTasks,
//         "status": status,
//         "remarks": remarks,
//         "images": images,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//     };
// }

// class Property {
//     int? id;
//     int? propertyOwnerId;
//     String? propertyName;
//     String? type;
//     int? assignStaff;
//     String? area;
//     String? country;
//     String? state;
//     String? city;
//     String? postCode;
//     String? propertyDescription;
//     String? location;
//     String? longitude;
//     String? latitude;
//     String? status;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     List<PropertyAvatar>? propertyAvatars;

//     Property({
//         this.id,
//         this.propertyOwnerId,
//         this.propertyName,
//         this.type,
//         this.assignStaff,
//         this.area,
//         this.country,
//         this.state,
//         this.city,
//         this.postCode,
//         this.propertyDescription,
//         this.location,
//         this.longitude,
//         this.latitude,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.propertyAvatars,
//     });

//     factory Property.fromJson(Map<String, dynamic> json) => Property(
//         id: json["id"],
//         propertyOwnerId: json["property_owner_id"],
//         propertyName: json["property_name"],
//         type: json["type"],
//         assignStaff: json["assign_staff"],
//         area: json["area"],
//         country: json["country"],
//         state: json["state"],
//         city: json["city"],
//         postCode: json["post_code"],
//         propertyDescription: json["property_description"],
//         location: json["location"],
//         longitude: json["longitude"],
//         latitude: json["latitude"],
//         status: json["status"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//         propertyAvatars: json["property_avatars"] == null ? [] : List<PropertyAvatar>.from(json["property_avatars"]!.map((x) => PropertyAvatar.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "property_owner_id": propertyOwnerId,
//         "property_name": propertyName,
//         "type": type,
//         "assign_staff": assignStaff,
//         "area": area,
//         "country": country,
//         "state": state,
//         "city": city,
//         "post_code": postCode,
//         "property_description": propertyDescription,
//         "location": location,
//         "longitude": longitude,
//         "latitude": latitude,
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "property_avatars": propertyAvatars == null ? [] : List<dynamic>.from(propertyAvatars!.map((x) => x.toJson())),
//     };
// }

// class PropertyAvatar {
//     int? id;
//     int? propertyOwnerId;
//     int? propertyId;
//     String? propertyAvatar;
//     DateTime? createdAt;
//     DateTime? updatedAt;

//     PropertyAvatar({
//         this.id,
//         this.propertyOwnerId,
//         this.propertyId,
//         this.propertyAvatar,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory PropertyAvatar.fromJson(Map<String, dynamic> json) => PropertyAvatar(
//         id: json["id"],
//         propertyOwnerId: json["property_owner_id"],
//         propertyId: json["property_id"],
//         propertyAvatar: json["property_avatar"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "property_owner_id": propertyOwnerId,
//         "property_id": propertyId,
//         "property_avatar": propertyAvatar,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//     };
// }






// To parse this JSON data, do
//
//     final checkPointDetailsModal = checkPointDetailsModalFromJson(jsonString);

import 'dart:convert';

CheckPointDetailsModal checkPointDetailsModalFromJson(String str) => CheckPointDetailsModal.fromJson(json.decode(str));

String checkPointDetailsModalToJson(CheckPointDetailsModal data) => json.encode(data.toJson());

class CheckPointDetailsModal {
    Data? data;
    String? imageBaseUrl;
    String? propertyImageBaseUrl;
    int? status;

    CheckPointDetailsModal({
        this.data,
        this.imageBaseUrl,
        this.propertyImageBaseUrl,
        this.status,
    });

    factory CheckPointDetailsModal.fromJson(Map<String, dynamic> json) => CheckPointDetailsModal(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        imageBaseUrl: json["image_base_url"],
        propertyImageBaseUrl: json["property_image_base_url"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "image_base_url": imageBaseUrl,
        "property_image_base_url": propertyImageBaseUrl,
        "status": status,
    };
}

class Data {
    int? id;
    int? propertyOwnerId;
    int? propertyId;
    String? propertyName;
    String? checkpointName;
    String? description;
    String? latitude;
    String? longitude;
    String? checkpointQrCode;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic taskRemarks;
    List<dynamic>? taskImages;
    List<CheckPointTask>? checkPointTask;
    Property? property;

    Data({
        this.id,
        this.propertyOwnerId,
        this.propertyId,
        this.propertyName,
        this.checkpointName,
        this.description,
        this.latitude,
        this.longitude,
        this.checkpointQrCode,
        this.createdAt,
        this.updatedAt,
        this.taskRemarks,
        this.taskImages,
        this.checkPointTask,
        this.property,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyId: json["property_id"],
        propertyName: json["property_name"],
        checkpointName: json["checkpoint_name"],
        description: json["description"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        checkpointQrCode: json["checkpoint_qr_code"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        taskRemarks: json["task_remarks"],
        taskImages: json["task_images"] == null ? [] : List<dynamic>.from(json["task_images"]!.map((x) => x)),
        checkPointTask: json["check_point_task"] == null ? [] : List<CheckPointTask>.from(json["check_point_task"]!.map((x) => CheckPointTask.fromJson(x))),
        property: json["property"] == null ? null : Property.fromJson(json["property"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_id": propertyId,
        "property_name": propertyName,
        "checkpoint_name": checkpointName,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
        "checkpoint_qr_code": checkpointQrCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "task_remarks": taskRemarks,
        "task_images": taskImages == null ? [] : List<dynamic>.from(taskImages!.map((x) => x)),
        "check_point_task": checkPointTask == null ? [] : List<dynamic>.from(checkPointTask!.map((x) => x.toJson())),
        "property": property?.toJson(),
    };
}

class CheckPointTask {
    int? id;
    int? propertyOwnerId;
    int? propertyId;
    int? checkpointId;
    String? checkpointTasks;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? status;
    dynamic remarks;
    dynamic images;

    CheckPointTask({
        this.id,
        this.propertyOwnerId,
        this.propertyId,
        this.checkpointId,
        this.checkpointTasks,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.remarks,
        this.images,
    });

    factory CheckPointTask.fromJson(Map<String, dynamic> json) => CheckPointTask(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyId: json["property_id"],
        checkpointId: json["checkpoint_id"],
        checkpointTasks: json["checkpoint_tasks"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        status: json["status"],
        remarks: json["remarks"],
        images: json["images"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_id": propertyId,
        "checkpoint_id": checkpointId,
        "checkpoint_tasks": checkpointTasks,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "remarks": remarks,
        "images": images,
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
    List<PropertyAvatar>? propertyAvatars;

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
        this.propertyAvatars,
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
        propertyAvatars: json["property_avatars"] == null ? [] : List<PropertyAvatar>.from(json["property_avatars"]!.map((x) => PropertyAvatar.fromJson(x))),
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
        "property_avatars": propertyAvatars == null ? [] : List<dynamic>.from(propertyAvatars!.map((x) => x.toJson())),
    };
}

class PropertyAvatar {
    int? id;
    int? propertyOwnerId;
    int? propertyId;
    String? propertyAvatar;
    DateTime? createdAt;
    DateTime? updatedAt;

    PropertyAvatar({
        this.id,
        this.propertyOwnerId,
        this.propertyId,
        this.propertyAvatar,
        this.createdAt,
        this.updatedAt,
    });

    factory PropertyAvatar.fromJson(Map<String, dynamic> json) => PropertyAvatar(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        propertyId: json["property_id"],
        propertyAvatar: json["property_avatar"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "property_id": propertyId,
        "property_avatar": propertyAvatar,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

