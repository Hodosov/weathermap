import 'dart:convert';
import 'dart:developer';

import 'package:weathermap/models/weather_forecast_daily.dart';
import 'package:weathermap/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:weathermap/utils/location.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecas(
      {String? cityName, bool? isCity}) async {
    Location location = Location();
    await location.getCurrentLocation();

    Map<String, String> parameters;

    if (cityName != null) {
      var queryParams = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'q': cityName
      };
      parameters = queryParams;
    } else {
      var queryParams = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'lat': location.lat.toString(),
        'lon': location.lon.toString()
      };
      parameters = queryParams;
    }

    var uri = Uri.https(Constants.WEATHER_BASE_URL,
        Constants.WEATHER_FORECAST_PATH, parameters);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error response');
    }
  }
}
