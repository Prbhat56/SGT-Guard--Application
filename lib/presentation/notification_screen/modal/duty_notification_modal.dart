// To parse this JSON data, do
//
//     final dutyNotification = dutyNotificationFromJson(jsonString);

import 'dart:convert';

DutyNotification dutyNotificationFromJson(String str) => DutyNotification.fromJson(json.decode(str));

String dutyNotificationToJson(DutyNotification data) => json.encode(data.toJson());

class DutyNotification {
    Response? response;
    int? status;

    DutyNotification({
        this.response,
        this.status,
    });

    factory DutyNotification.fromJson(Map<String, dynamic> json) => DutyNotification(
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
    List<DutyDatum>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    dynamic nextPageUrl;
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
        data: json["data"] == null ? [] : List<DutyDatum>.from(json["data"]!.map((x) => DutyDatum.fromJson(x))),
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

class DutyDatum {
    int? id;
    int? userId;
    String? notificationFor;
    String? category;
    String? message;
    DateTime? readAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? notificationTime;
    String? notificationDate;
    String? userAvtar;

    DutyDatum({
        this.id,
        this.userId,
        this.notificationFor,
        this.category,
        this.message,
        this.readAt,
        this.createdAt,
        this.updatedAt,
        this.notificationTime,
        this.notificationDate,
        this.userAvtar,
    });

    factory DutyDatum.fromJson(Map<String, dynamic> json) => DutyDatum(
        id: json["id"],
        userId: json["user_id"],
        notificationFor: json["notification_for"],
        category: json["category"],
        message: json["message"],
        readAt: json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        notificationTime: json["notification_time"],
        notificationDate: json["notification_date"],
        userAvtar: json["user_avtar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "notification_for": notificationFor,
        "category": category,
        "message": message,
        "read_at": readAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "notification_time": notificationTime,
        "notification_date": notificationDate,
        "user_avtar": userAvtar,
    };
}

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
