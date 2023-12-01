import 'dart:convert';

class StateModel {
    List<States>? states;
    int? status;

    StateModel({
        this.states,
        this.status,
    });

    factory StateModel.fromRawJson(String str) => StateModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        states: json["states"] == null ? [] : List<States>.from(json["states"]!.map((x) => States.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "states": states == null ? [] : List<dynamic>.from(states!.map((x) => x.toJson())),
        "status": status,
    };
}

class States {
    int? id;
    String? name;
    int? countryId;
    dynamic createdAt;
    dynamic updatedAt;

    States({
        this.id,
        this.name,
        this.countryId,
        this.createdAt,
        this.updatedAt,
    });

    factory States.fromRawJson(String str) => States.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory States.fromJson(Map<String, dynamic> json) => States(
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
