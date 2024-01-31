// To parse this JSON data, do
//
//     final generalNotification = generalNotificationFromJson(jsonString);

import 'dart:convert';

GeneralNotification generalNotificationFromJson(String str) => GeneralNotification.fromJson(json.decode(str));

String generalNotificationToJson(GeneralNotification data) => json.encode(data.toJson());

class GeneralNotification {
    Response? response;
    int? status;

    GeneralNotification({
        this.response,
        this.status,
    });

    factory GeneralNotification.fromJson(Map<String, dynamic> json) => GeneralNotification(
        response: json["response"] == null ? null : Response.fromJson(json["response"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "response": response?.toJson(),
        "status": status,
    };
}

class Response {
    int? currentPage;
    List<Datum>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    String? nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    Response({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    int? id;
    int? userId;
    NotificationFor? notificationFor;
    Category? category;
    String? message;
    DateTime? readAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? notificationTime;
    String? userAvtar;

    Datum({
        this.id,
        this.userId,
        this.notificationFor,
        this.category,
        this.message,
        this.readAt,
        this.createdAt,
        this.updatedAt,
        this.notificationTime,
        this.userAvtar,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        notificationFor: notificationForValues.map[json["notification_for"]]!,
        category: categoryValues.map[json["category"]]!,
        message: json["message"],
        readAt: json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        notificationTime: json["notification_time"],
        userAvtar: json["user_avtar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "notification_for": notificationForValues.reverse[notificationFor],
        "category": categoryValues.reverse[category],
        "message": message,
        "read_at": readAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "notification_time": notificationTime,
        "user_avtar": userAvtar,
    };
}

enum Category {
    GENERAL
}

final categoryValues = EnumValues({
    "general": Category.GENERAL
});

enum NotificationFor {
    GUARD
}

final notificationForValues = EnumValues({
    "guard": NotificationFor.GUARD
});

// enum NotificationTime {
//     THE_1200_AM
// }

// final notificationTimeValues = EnumValues({
//     "12:00 AM": NotificationTime.THE_1200_AM
// });

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
