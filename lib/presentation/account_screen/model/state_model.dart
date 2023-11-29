class StateModel {
    List<States>? states;
    int? status;

    StateModel({
        this.states,
        this.status,
    });

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

}
