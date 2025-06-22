import 'dart:convert';

import 'package:http/http.dart' as http;

class OpenweatherAPI {
  final String apiKey;
  const OpenweatherAPI(this.apiKey); // b7d45d012b8769ed4d909a3e68d1e883

  Future<Map> getWeatherDetails({
    required double lat,
    required double lon,
  }) async {
    var url =
        "https://api.openweathermap.org/data/2.5/weather?units=metric&lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=en";

    var res = await http.get(Uri.parse(url));
    return jsonDecode(res.body);
  }

  String getWeatherIcon(String icon) {
    return "https://openweathermap.org/img/wn/$icon@4x.png";
  }
}
