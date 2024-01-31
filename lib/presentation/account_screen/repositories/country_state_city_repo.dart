import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sgt/presentation/account_screen/model/city_model.dart';
import 'package:sgt/presentation/account_screen/model/country_model.dart';
import 'package:sgt/presentation/account_screen/model/state_model.dart';
import 'package:sgt/service/constant/constant.dart';

class CountryStateCityRepo {
  Future<CountryModel> getCountries() async {
    try {
      String apiUrl = baseUrl + apiRoutes['country']!;
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final CountryModel responseModel = countryModelFromJson(response.body);
        return responseModel;
      } else {
        return CountryModel(countries: [], status: response.statusCode);
      }
    } catch (e) {
      log('Exception: ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  Future<StateModel> getStates({required int countryCode}) async {
    try {
      String apiUrl = baseUrl + apiRoutes['state']!;
      Map<String, String> myJsonBody = {
        'country_id': countryCode.toString(),
      };
      var response = await http.post(Uri.parse(apiUrl), body: myJsonBody);

      if (response.statusCode == 200) {
        final StateModel responseModel = stateModelFromJson(response.body);
        return responseModel;
      } else {
        return StateModel(
          states: [],
          status: response.statusCode,
        );
      }
    } catch (e) {
      log('Exception: ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  Future<CityModel> getCities({required int stateCode}) async {
    try {
      String apiUrl = baseUrl + apiRoutes['city']!;
      Map<String, String> myJsonBody = {
        'state_id': stateCode.toString(),
      };
      var response = await http.post(Uri.parse(apiUrl), body: myJsonBody);

      if (response.statusCode == 200) {
        final CityModel responseModel = citiesModelFromJson(response.body);
        return responseModel;
      } else {
        return CityModel(
          cities: [],
          status: response.statusCode,
        );
      }
    } catch (e) {
      log('Exception: ${e.toString()}');
      throw Exception(e.toString());
    }
  }
}
