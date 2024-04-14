class Weather {
  // summary/description
  // windspead
  //humidity
  // visibility
  // weekly forecast (replace with daily forecast)
  // 1. sunrise
  // 2. sunset
  // 3. moonrise
  // 4. moonset
  late final double temp;
  late final String weatherMain;
  late final String description;
  late final String summary;
  late final double windSpeed;
  late final int humidity;
  late final int visibility;
  late final double morningTemp;
  late final double dayTemp;
  late final double eveTemp;
  late final double nightTemp;

  Weather(
      {required this.temp,
      required this.weatherMain,
      required this.description,
      required this.summary,
      required this.windSpeed,
      required this.humidity,
      required this.visibility,
      required this.morningTemp,
      required this.dayTemp,
      required this.eveTemp,
      required this.nightTemp});

  factory Weather.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return Weather(
        temp: json['current']['temp'],
        weatherMain: json['current']['weather'][0]['main'],
        description: json['current']['weather'][0]['description'],
        summary: json['daily'][0]['summary'],
        humidity: json['daily'][0]['humidity'],
        visibility: json['current']['visibility'],
        windSpeed: json['current']['wind_speed'],
        morningTemp: json['daily'][0]['temp']['morn'],
        dayTemp: json['daily'][0]['temp']['day'],
        eveTemp: json['daily'][0]['temp']['eve'],
        nightTemp: json['daily'][0]['temp']['night'],
      );
    } else {
      throw const FormatException('Failed to load album.');
    }
    // return switch (json) {
    //   {
    //     'temp': double temp,
    //     'id': String weatherMain,
    //     'description': String description,
    //   } =>
    //     Weather(
    //       temp: temp,
    //       weatherMain: weatherMain,
    //       description: description,
    //     ),
    //   _ => throw const FormatException('Failed to load album.'),
    // };
  }
}
