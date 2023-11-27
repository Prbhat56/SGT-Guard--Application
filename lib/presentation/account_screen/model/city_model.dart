class CityModel {
    List<City>? cities;
    int? status;

    CityModel({
        this.cities,
        this.status,
    });

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

}
