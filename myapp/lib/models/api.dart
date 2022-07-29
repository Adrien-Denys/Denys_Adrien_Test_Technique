import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  String endPoint;

  Api(this.endPoint);

  static Future<Map<String, dynamic>> getData(String endPoint) async {
    final repServer = await http.get(Uri.parse(endPoint));
    var data;

    print("status code " + repServer.statusCode.toString());

    if (repServer.statusCode == 200) {
      print("Reponse serveur " + repServer.body);
      data = jsonDecode(repServer.body);
    }

    return data;
  }
}
