import 'dart:convert';
import 'dart:developer';

import 'package:weathermap/models/weather_forecast_daily.dart';
import 'package:weathermap/utils/constants.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecasWithCity(
      {required String cityName}) async {
    var queryParams = {
      'APPID': Constants.WEATHER_APP_ID,
      'units': 'metric',
      'q': cityName
    };

    var uri = Uri.https(Constants.WEATHER_BASE_URL,
        Constants.WEATHER_FORECAST_PATH, queryParams);

    log('request: ${uri.toString()}');

    var response = await http.get(uri);

    print(response.body);

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error response');
    }
  }
}
