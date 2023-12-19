// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

LeaveListModel leaveModelFromJson(String str) =>
    LeaveListModel.fromJson(json.decode(str));

String leaveModelToJson(LeaveListModel data) => json.encode(data.toJson());

class LeaveListModel {
  LeaveStatusResponse? response;
  int? status;

  LeaveListModel({
    this.response,
    this.status,
  });

  factory LeaveListModel.fromRawJson(String str) =>
      LeaveListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaveListModel.fromJson(Map<String, dynamic> json) => LeaveListModel(
        response: json["response"] == null
            ? null
            : LeaveStatusResponse.fromJson(json["response"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "response": response?.toJson(),
        "status": status,
      };
}

class LeaveStatusResponse {
  int? currentPage;
  List<LeaveDatum>? data;
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

  LeaveStatusResponse({
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

  factory LeaveStatusResponse.fromRawJson(String str) =>
      LeaveStatusResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaveStatusResponse.fromJson(Map<String, dynamic> json) =>
      LeaveStatusResponse(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<LeaveDatum>.from(
                json["data"]!.map((x) => LeaveDatum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class LeaveDatum {
  int? id;
  int? propertyOwnerId;
  int? guardId;
  DateTime? leaveFrom;
  DateTime? leaveTo;
  String? subject;
  String? status;
  String? reasonOfLeave;
  dynamic rejectOfReason;
  DateTime? createdAt;
  DateTime? updatedAt;

  LeaveDatum({
    this.id,
    this.propertyOwnerId,
    this.guardId,
    this.leaveFrom,
    this.leaveTo,
    this.subject,
    this.status,
    this.reasonOfLeave,
    this.rejectOfReason,
    this.createdAt,
    this.updatedAt,
  });

  factory LeaveDatum.fromRawJson(String str) =>
      LeaveDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LeaveDatum.fromJson(Map<String, dynamic> json) => LeaveDatum(
        id: json["id"],
        propertyOwnerId: json["property_owner_id"],
        guardId: json["guard_id"],
        leaveFrom: json["leave_from"] == null
            ? null
            : DateTime.parse(json["leave_from"]),
        leaveTo:
            json["leave_to"] == null ? null : DateTime.parse(json["leave_to"]),
        subject: json["subject"],
        status: json["status"],
        reasonOfLeave: json["reason_of_leave"],
        rejectOfReason: json["reject_of_reason"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_owner_id": propertyOwnerId,
        "guard_id": guardId,
        "leave_from":
            "${leaveFrom!.year.toString().padLeft(4, '0')}-${leaveFrom!.month.toString().padLeft(2, '0')}-${leaveFrom!.day.toString().padLeft(2, '0')}",
        "leave_to":
            "${leaveTo!.year.toString().padLeft(4, '0')}-${leaveTo!.month.toString().padLeft(2, '0')}-${leaveTo!.day.toString().padLeft(2, '0')}",
        "subject": subject,
        "status": status,
        "reason_of_leave": reasonOfLeave,
        "reject_of_reason": rejectOfReason,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

class LeaveDetailModel {
  final String imageUrl;
  final String status;
  final String date;
  LeaveDetailModel({
    required this.imageUrl,
    required this.status,
    required this.date,
  });
}

List<LeaveDetailModel> leaveData = [
  LeaveDetailModel(
      imageUrl:
          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
      status: 'Approved',
      date: 'Monday, 23 October'),
  LeaveDetailModel(
      imageUrl:
          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
      status: 'Waiting For Approval',
      date: 'Monday, 23 October'),
  LeaveDetailModel(
      imageUrl:
          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
      status: 'Not Approved',
      date: 'Monday, 13 October'),
  LeaveDetailModel(
      imageUrl:
          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?cs=srgb&dl=pexels-binyamin-mellish-186077.jpg&fm=jpg',
      status: 'Not Approved',
      date: 'Monday, 03 October'),
];
