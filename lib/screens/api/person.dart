import 'dart:convert';
import 'package:http/http.dart' as http;

class Person {
  String apiUrl = "http://13.233.93.36/api/?uidai=3";
  Future<List> getData() async {
    try {
      var res = await http.get(Uri.parse(apiUrl));
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        return Future.error("API get Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
