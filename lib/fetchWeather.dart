import 'dart:convert';
// import 'package:geolocator/geolocator.dart';
// import 'package:weather_application/fetchLocation.dart';
import 'package:weather_application/weatherModel.dart';
import 'package:http/http.dart' as http;

Future<Weather> fetchWeather(lat, long) async {
  // Future<Position> futurePosition = determinePosition();
  // late double lat;
  // late double long;
  // late dynamic response;
  // Future<Position> futurePosition = determinePosition();

  // List weatherData = [];
  final response = await http.get(Uri.parse('testapi'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print("woii" +
    //     Weather.fromJson(jsonDecode(response.body) as Map<String, dynamic>)
    //         .toString().toJson());
    // for (Map<String, dynamic> index in data) {
    //     userData.add(UserModels.fromJson(index));
    //   }
    return Weather.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    // for (var eachWeather in )
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
