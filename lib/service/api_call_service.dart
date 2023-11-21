import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/service/common_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;

class ApiCallMethodsService {
 
  void emitUserDetail(dynamic data) {
    // List<dynamic> myDynamicList = [data];
    globals.userDetail = data;
    print("obje ==>  ${globals.userDetail}");
  }

  
  Future<dynamic> get(String url) async {
    String apiUrl = baseUrl + url;
    var headers = {
      'Authorization': 'Bearer ${await _getToken()}',
    };

    var response = await http.get(Uri.parse(apiUrl), headers: headers);
    return response.body;
  }

  Future<dynamic> post(String url, dynamic data) async {
    String apiUrl = baseUrl + url;
    var headers = {
      'Authorization': 'Bearer ${await _getToken()}',
    };

    var response = await http.post(Uri.parse(apiUrl), body: data, headers: headers);
    return response.body;
  }

  Future<dynamic> postShare(String url, dynamic data) async {
    String apiUrl = baseUrl + url;
    var headers = {
      'Authorization': 'Bearer ${await _getToken()}',
    };
     var response;
      print(data.runtimeType);
    // if (typeofEquals(data, '_JsonMap')) {
        var formData = http.MultipartRequest('POST', Uri.parse(apiUrl));
      
                formData.headers.addAll(headers);

          // Convert JSON data to FormData fields

        data.forEach((key, value) {
          if (value != null) {
            formData.fields[key] = value.toString();
          }
        });
       
          try {
            // Send the request
             response = await formData.send();

            // Check the response
            // if (response.statusCode == 200) {
            //   print("Request successful: ${await response.stream.bytesToString()}");
            // } else {
            //   print("Error: ${response.reasonPhrase}");
            // }
          } catch (error) {
            print("Error sending request: $error");
          }
    // } else {
    //   print("KKKK");
    //     response = await http.post(Uri.parse(apiUrl), body: data, headers: headers);
        
    // }
    return response.body;
  }

  Future<dynamic> put(String url, dynamic data) async {
    String apiUrl = baseUrl + url;
    var headers = {
      'Authorization': 'Bearer ${await _getToken()}',
    };

    var response = await http.put(Uri.parse(apiUrl), body: data, headers: headers);
    return response.body;
  }

  Future<dynamic> delete(String url) async {
    String apiUrl = baseUrl + url;
    var headers = {
      'Authorization': 'Bearer ${await _getToken()}',
    };

    var response = await http.delete(Uri.parse(apiUrl), headers: headers);
    return response.body;
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void updateUserDetails(userDetail) {
        emitUserDetail(userDetail.toString());
        var commonService = CommonService();
        commonService.setUserDetail(userDetail.toString());
  }


  // Future<void> logOut() async {
  //   try {
  //     var response = await get(apiRoutes.logOut);
  //     var jsonResponse = json.decode(response);
  //     commonService.openSnackBar(jsonResponse['message']);
  //     await commonService.clearLocalStorage();
  //     commonService.setUserDetail(null);
  //     userDetail.add(null);
  //     commonService.userLoggedOut.add(null);
  //     router.navigate(['home']);
  //   } catch (error) {
  //     print(error);
  //     commonService.openSnackBar(error['message']);
  //   }
  // }
}






// import 'package:http/http.dart' as http;

// Future<void> main() async {
//   // Define the base URL of your API
//   final String baseUrl = 'https://example.com/api';

//   // Perform a GET request
//   await performGetRequest('$baseUrl/resource');

//   // Perform a POST request
//   await performPostRequest('$baseUrl/resource', {'key': 'value'});

//   // Perform a PUT request
//   await performPutRequest('$baseUrl/resource/1', {'key': 'updatedValue'});

//   // Perform a DELETE request
//   await performDeleteRequest('$baseUrl/resource/1');
// }

// Future<void> performGetRequest(String url) async {
//   final response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     print('GET Request Successful');
//     print('Response: ${response.body}');
//   } else {
//     print('GET Request Failed');
//     print('Status Code: ${response.statusCode}');
//   }
// }

// Future<void> performPostRequest(String url, Map<String, String> body) async {
//   final response = await http.post(
//     Uri.parse(url),
//     body: body,
//   );

//   if (response.statusCode == 200) {
//     print('POST Request Successful');
//     print('Response: ${response.body}');
//   } else {
//     print('POST Request Failed');
//     print('Status Code: ${response.statusCode}');
//   }
// }

// Future<void> performPutRequest(String url, Map<String, String> body) async {
//   final response = await http.put(
//     Uri.parse(url),
//     body: body,
//   );

//   if (response.statusCode == 200) {
//     print('PUT Request Successful');
//     print('Response: ${response.body}');
//   } else {
//     print('PUT Request Failed');
//     print('Status Code: ${response.statusCode}');
//   }
// }

// Future<void> performDeleteRequest(String url) async {
//   final response = await http.delete(Uri.parse(url));

//   if (response.statusCode == 200) {
//     print('DELETE Request Successful');
//     print('Response: ${response.body}');
//   } else {
//     print('DELETE Request Failed');
//     print('Status Code: ${response.statusCode}');
//   }
// }

