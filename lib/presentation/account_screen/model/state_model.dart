import 'dart:convert';

StateModel stateModelFromJson(String str) =>
    StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  List<state> states;
  int? status;

  StateModel({
    required this.states,
    this.status,
  });

  factory StateModel.fromRawJson(String str) =>
      StateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        states: json["states"] == null
            ? []
            : List<state>.from(json["states"]!.map((x) => state.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "states": states == null
            ? []
            : List<dynamic>.from(states!.map((x) => x.toJson())),
        "status": status,
      };
}

class state {
  int? id;
  String? name;
  int? countryId;
  dynamic createdAt;
  dynamic updatedAt;

  state({
    this.id,
    this.name,
    this.countryId,
    this.createdAt,
    this.updatedAt,
  });

  factory state.fromRawJson(String str) => state.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory state.fromJson(Map<String, dynamic> json) => state(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
