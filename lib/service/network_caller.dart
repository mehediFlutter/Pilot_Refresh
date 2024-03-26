import 'dart:convert';
import 'package:http/http.dart';
import 'package:pilot_refresh/service/network_response.dart';


class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url),
          headers: {'Accept':'application/vnd.api+json','Content-Type':'application/vnd.api+json'});
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      print(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  // Post()
  Future<NetworkResponse> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      Response response = await post(Uri.parse(url),
          headers: {
          'Accept':'application/vnd.api+json','Content-Type':'application/vnd.api+json'
          },
          body: jsonEncode(body));
      print(response.statusCode);
      print(response.body.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      print(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }


}