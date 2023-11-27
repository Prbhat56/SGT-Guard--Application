class CountryModel {
    List<Country>? countries;
    int? status;

    CountryModel({
        this.countries,
        this.status, required bool error, required String msg, required List data,
    });

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

}
