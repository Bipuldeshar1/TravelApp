import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

// class LocationService {
//   final String key = 'AIzaSyDaqkp7BSmJSFgAzrEp66ORSNSW7VyQeSo';
//   Future<String> getPlaceId(String input) async {
//     final String url =
//         'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
//     var response = await http.get(Uri.parse(url));
//     var json = convert.jsonDecode(response.body);
//     var placeId = json['candidates'][0]['place_id'] as String;

//     return placeId;
//   }

//   Future<Map<String, dynamic>> getPlace(String input) async {
//     final placeId = await getPlaceId(input);
//     final String url =
//         'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
//     var response = await http.get(Uri.parse(url));
//     var json = convert.jsonDecode(response.body);
//     var result = json['result'] as Map<String, dynamic>;
//     print(result);
//     return result;
//   }
// }

class LocationService {
  final String key = 'AIzaSyDaqkp7BSmJSFgAzrEp66ORSNSW7VyQeSo';

  Future<String> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    if (json['status'] == 'OK') {
      var candidates = json['candidates'] as List<dynamic>;
      if (candidates.isNotEmpty) {
        var placeId = candidates[0]['place_id'] as String;
        return placeId;
      } else {
        throw Exception('No candidates found for input: $input');
      }
    } else {
      throw Exception(json['error_message'] ?? 'Unknown error');
    }
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getPlaceId(input);
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var result = json['result'] as Map<String, dynamic>;
    print(result);
    return result;
  }
}
