import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgt/presentation/account_screen/model/cities_model.dart';
import 'package:sgt/presentation/account_screen/model/country_model.dart';
import 'package:sgt/presentation/account_screen/repositories/country_state_city_repo.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/service/globals.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/country_state_model.dart' as cs_model;


var userD = jsonDecode(userDetail);
class dropdownCountry extends StatefulWidget {

   @override
  State<dropdownCountry> createState() => _dropdownCountryState();
}

class _dropdownCountryState extends State<dropdownCountry> {
  final CountryStateCityRepo _countryStateCityRepo = CountryStateCityRepo();
  List<String> countries = [];
  List<String> states = [];
  List<String> cities = [];

  cs_model.CountryStateModel countryStateModel =
      cs_model.CountryStateModel(error: false, msg: '', data: []);
  CitiesModel citiesModel = CitiesModel(error: false, msg: '', data: []);

  String selectedCountry = 'Select Country';
  String selectedState = 'Select State';
  String selectedCity = 'Select City';
  bool isDataLoaded = false;
  String finalTextToBeDisplayed = '';

  getCountries() async {
    //
    countryStateModel = await _countryStateCityRepo.getCountriesStates();
    countries.add('Select Country');
    for (var element in countryStateModel.data) {
      countries.add(element.name);
    }
    isDataLoaded = true;
    setState(() {});
    //
  }
  getStates() async {
      //
      for (var element in countryStateModel.data) {
        if (selectedCountry == element.name) {
          //
          setState(() {
            resetStates();
            resetCities();
          });
          //
          for (var state in element.states) {
            states.add(state.name);
          }
        }
      }
      //
    }
     getCities() async {
        //
        isDataLoaded = false;
        citiesModel = await _countryStateCityRepo.getCities(
            country: selectedCountry, state: selectedState);
        setState(() {
          resetCities();
        });
        for (var city in citiesModel.data) {
          cities.add(city);
        }
        isDataLoaded = true;
        setState(() {});
        //
      }
      resetCities() {
        cities = [];
        cities.add('Select City');
        selectedCity = 'Select City';
        finalTextToBeDisplayed = '';
      }

      resetStates() {
        states = [];
        states.add('Select State');
        selectedState = 'Select State';
        finalTextToBeDisplayed = '';
      }
  @override
  void initState() {
    getCountries();
    super.initState();
  }

//  Future<dynamic> getCountryAPI() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     Map<String, String> myHeader = <String, String>{
//       "Authorization": "Bearer ${prefs.getString('token')}",
//     };
//     // print(myHeader);

//     String apiUrl = baseUrl + apiRoutes['country']!;
//     final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
//     var data = jsonDecode(response.body.toString());

//     if (response.statusCode == 200) {
//       return data;
//     } else {
//       setState(() {
//         return data;
//       });
//     }
//   }

  @override
  Widget build(BuildContext context) {
  // String selectedCountry = (userD['user_details']['country_text'] !=null ? userD['user_details']['country_text']:'Select Country');
    return Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Country',
                        style: CustomTheme.textField_Headertext_Style,
                        textScaleFactor: 1.0,
                      ),
                    ),
                    DropdownButton(
                        isExpanded: true,
                        value: selectedCountry,
                        items: countries
                            .map((String country) => DropdownMenuItem(
                                value: country, child: Text(country)))
                            .toList(),
                        onChanged: (selectedValue) {
                          //
                          setState(() {
                            selectedCountry = selectedValue!;
                          });
                          // In Video we have used getStates();
                          // getStates();
                          // But for improvement we can use one extra check
                          if (selectedCountry != 'Select Country') {
                            getStates();
                          }
                          //
                        }),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'State',
                        style: CustomTheme.textField_Headertext_Style,
                        textScaleFactor: 1.0,
                      ),
                    ),
                    DropdownButton(
                        isExpanded: true,
                        value: selectedState,
                        items: states
                            .map((String state) => DropdownMenuItem(
                                value: state, child: Text(state)))
                            .toList(),
                        onChanged: (selectedValue) {
                          //
                          setState(() {
                            selectedState = selectedValue!;
                          });
                          if (selectedState != 'Select State') {
                            getCities();
                          }
                          //
                        }),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'City',
                        style: CustomTheme.textField_Headertext_Style,
                        textScaleFactor: 1.0,
                      ),
                    ),
                    DropdownButton(
                        isExpanded: true,
                        value: selectedCity,
                        items: cities
                            .map((String city) => DropdownMenuItem(
                                value: city, child: Text(city)))
                            .toList(),
                        onChanged: (selectedValue) {
                          //
                          setState(() {
                            selectedCity = selectedValue!;
                          });
                          if (selectedCity != 'Select City') {
                            finalTextToBeDisplayed =
                                "Country: $selectedCountry\nState: $selectedState\nCity: $selectedCity";
                          }
                          //
                        }),
                    // Text(
                    //   finalTextToBeDisplayed,
                    //   style: const TextStyle(fontSize: 22),
                    // ),
                  ],
                )
                );
  }
}
