import 'package:flutter/material.dart';
import 'package:sgt/presentation/account_screen/edit_account_details_screen.dart';
import 'package:sgt/presentation/account_screen/model/city_model.dart';
import 'package:sgt/presentation/account_screen/model/country_model.dart'
    as c_model;
import 'package:sgt/presentation/account_screen/model/country_model.dart';
import 'package:sgt/presentation/account_screen/model/state_model.dart'
    as s_model;
import 'package:sgt/presentation/account_screen/model/state_model.dart';
import 'package:sgt/presentation/account_screen/repositories/country_state_city_repo.dart';
import 'package:sgt/service/globals.dart';
import 'package:sgt/theme/custom_theme.dart';

class DropdownCountry extends StatefulWidget {
  String cName;
  int cId;
  String sName;
  int sId;
  String cityName;
  int citId;
  DropdownCountry(
      {super.key,
      required this.cName,
      required this.cId,
      required this.sName,
      required this.sId,
      required this.cityName,
      required this.citId});
  @override
  State<DropdownCountry> createState() => _DropdownCountryState(
      cName: cName,
      cId: cId,
      sName: sName,
      sId: sId,
      cityName: cityName,
      citId: citId);
}

class _DropdownCountryState extends State<DropdownCountry> {
  _DropdownCountryState(
      {required this.cName,
      required this.cId,
      required this.sName,
      required this.sId,
      required this.cityName,
      required this.citId});

  final CountryStateCityRepo _countryStateCityRepo = CountryStateCityRepo();
  String cName;
  int cId;
  String sName;
  int sId;
  String cityName;
  int citId;

  c_model.CountryModel countryModel =
      c_model.CountryModel(countries: [], status: 500);
  s_model.StateModel stateModel = s_model.StateModel(states: [], status: 500);
  CityModel cityModel = CityModel(cities: [], status: 500);

  Country? selectedCountry;
  state? selectedState;
  City? selectedCity;

  bool isDataLoaded = false;

  getCountries() async {
    //
    setState(() {
      isDataLoaded = false;
    });
    countryModel = await _countryStateCityRepo.getCountries();
    // for (var element in countryModel.countries ?? []) {
    //   countries.add(element.name ?? "");
    //   countriesId.add(element.id ?? -1);
    // }
    setState(() {
      isDataLoaded = true;
    });
    //
  }

  getStates(int cId) async {
    //
    setState(() {
      isDataLoaded = false;
    });

    stateModel = await _countryStateCityRepo.getStates(countryCode: cId);
    setState(() {
      isDataLoaded = true;
    });
    //
  }

  getCities(int sId) async {
    //
    setState(() {
      isDataLoaded = false;
    });
    cityModel = await _countryStateCityRepo.getCities(stateCode: sId);
    setState(() {
      isDataLoaded = true;
    });
    //
  }

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  loadInitialData() async {
    await getCountries();
    selectedCountry = countryModel.countries.firstWhere(
      (element) {
        return element.id == cId;
      },
    );
    await getStates(cId);
    selectedState = stateModel.states.firstWhere(
      (element) {
        return element.id == sId;
      },
    );

    await getCities(sId);

    selectedCity = cityModel.cities.firstWhere(
      (element) {
        return element.id == citId;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Country',
        style: CustomTheme.textField_Headertext_Style,
        textScaleFactor: 1.0,
      ),
      !isDataLoaded
          ? Center(child: CircularProgressIndicator())
          : DropdownButtonFormField<Country>(
              isDense: true,
              value: selectedCountry,
              items: countryModel.countries
                  .map((Country items) => DropdownMenuItem(
                      value: items, child: Text(items.name.toString())))
                  .toList(),
              onChanged: (newValue) async {
                //int index = countries.indexOf(newValue);
                if (newValue != null) {
                  selectedCountry = newValue;
                  selectedState = null;
                  selectedCity = null;
                  cId = newValue.id!;
                  EditAccountScreen.of(context)?.countryId = cId;
                }
                await getStates(cId);
              }),
      const SizedBox(
        height: 20,
      ),
      Text(
        'State',
        style: CustomTheme.textField_Headertext_Style,
        textScaleFactor: 1.0,
      ),
      DropdownButtonFormField<state?>(
          isDense: true,
          value: selectedState,
          items: stateModel.states
              .map((state items) => DropdownMenuItem(
                  value: items, child: Text(items.name.toString())))
              .toList(),
          onChanged: (newValue) async {
            //int index = states.indexOf(newValue);
            if (newValue != null) {
              selectedState = newValue;
              selectedCity = null;
              sId = newValue.id!;
              EditAccountScreen.of(context)?.stateId = sId;
            }
            await getCities(sId);
          }),
      const SizedBox(
        height: 20,
      ),
      Text(
        'City',
        style: CustomTheme.textField_Headertext_Style,
        textScaleFactor: 1.0,
      ),
      DropdownButtonFormField<City>(
          isDense: true,
          value: selectedCity,
          items: cityModel.cities
              .map((City items) => DropdownMenuItem(
                  value: items, child: Text(items.name.toString())))
              .toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              selectedCity = newValue;
              citId = newValue.id!;
              EditAccountScreen.of(context)?.cityId = citId;
            }
          }),
    ]);
  }
}
