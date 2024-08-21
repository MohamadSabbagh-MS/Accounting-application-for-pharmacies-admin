import 'dart:convert';

import 'package:http/http.dart' as http;

class get_post {
  getRequset(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch $e");
    }
  }

  postRequset(String url, Map data) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        body: data,
      );
      print("-=-=-=-=-=-");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        var responseBody = utf8.decode(response.bodyBytes);
        print(responseBody);
        if (isJson(responseBody)) {
          var decodedResponse = jsonDecode(responseBody);
          print("response!!" + jsonEncode(decodedResponse));
          return decodedResponse;
        } else {
          print("Invalid JSON format in response");
        }
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch $e");
    }
  }

  bool isJson(String str) {
    try {
      jsonDecode(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
