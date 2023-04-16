import 'dart:convert';

import 'package:epal/modules/modules.dart';
import 'package:http/http.dart' as http;

class FetchModule {
  var data = [];

  List<module> results = [];
  Future<List<module>> getModuleList() async {
    final String apiUrl = 'http://127.0.0.1:8000/api/modulesuivis';
    final response = await http.get(Uri.parse(apiUrl));
    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => module.fromJson(e)).toList();
      } else {
        print("error");
      }
    } on Exception catch (e) {
      print(e);
    }
    return results;
  }
}
