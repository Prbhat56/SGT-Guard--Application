import 'dart:convert';

CityModel citiesModelFromJson(String str) =>
    CityModel.fromJson(json.decode(str));

String citiesModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  List<City> cities;
  int? status;

  CityModel({
    required this.cities,
    this.status,
  });

  factory CityModel.fromRawJson(String str) =>
      CityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        cities: json["cities"] == null
            ? []
            : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "cities": cities == null
            ? []
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
        "status": status,
      };
}

class City {
  int? id;
  String? name;
  int? stateId;
  dynamic createdAt;
  dynamic updatedAt;

  City({
    this.id,
    this.name,
    this.stateId,
    this.createdAt,
    this.updatedAt,
  });

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
