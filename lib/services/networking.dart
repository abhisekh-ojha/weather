import 'package:http/http.dart' as http;
import 'dart:convert';

// This file use URL and send API request to internet and fetch current weather

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
      // dart convert function jsonDecode to decode the raw data

    } else {
      print(response.statusCode);
    }
  }
}
