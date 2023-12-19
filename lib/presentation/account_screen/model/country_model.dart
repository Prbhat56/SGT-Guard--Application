import 'dart:convert';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  List<Country> countries;
  int? status;

  CountryModel({
    required this.countries,
    this.status,
  });

  factory CountryModel.fromRawJson(String str) =>
      CountryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        countries: json["countries"] == null
            ? []
            : List<Country>.from(
                json["countries"]!.map((x) => Country.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "countries": countries == null
            ? []
            : List<dynamic>.from(countries!.map((x) => x.toJson())),
        "status": status,
      };
}

class Country {
  int? id;
  String? name;
  String? sortname;
  String? phonecode;
  dynamic createdAt;
  dynamic updatedAt;

  Country({
    this.id,
    this.name,
    this.sortname,
    this.phonecode,
    this.createdAt,
    this.updatedAt,
  });

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        sortname: json["sortname"],
        phonecode: json["phonecode"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sortname": sortname,
        "phonecode": phonecode,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
