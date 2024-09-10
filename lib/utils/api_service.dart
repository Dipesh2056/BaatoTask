import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> fetchPOIs(double latitude, double longitude) async {
    final url = 'https://api.baato.io/api/v1/places?lat=$latitude&lon=$longitude&key=bpk.FhqCNwsqS3vQz6KNopKlBOhudT4A_oPf5yOE4OMGW9Lr';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load POIs');
    }
  }

  static Future<Map<String, dynamic>> fetchLocationDetails(double latitude, double longitude) async {
    final url = 'https://api.baato.io/api/v1/reverse?lat=$latitude&lon=$longitude&key=bpk.FhqCNwsqS3vQz6KNopKlBOhudT4A_oPf5yOE4OMGW9Lr';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load location details');
    }
  }
}
