class StateModel {
    List<State>? states;
    int? status;

    StateModel({
        this.states,
        this.status,
    });

}

class State {
    int? id;
    String? name;
    int? countryId;
    dynamic createdAt;
    dynamic updatedAt;

    State({
        this.id,
        this.name,
        this.countryId,
        this.createdAt,
        this.updatedAt,
    });

}
