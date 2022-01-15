import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weathermap/api/weather_api.dart';
import 'package:weathermap/models/weather_forecast_daily.dart';
import 'package:weathermap/screens/city_screen.dart';
import 'package:weathermap/widgets/bottom_list_view.dart';
import 'package:weathermap/widgets/city_view.dart';
import 'package:weathermap/widgets/detail_view.dart';
import 'package:weathermap/widgets/temp_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  WeatherForecastScreen({Key? key}) : super(key: key);

  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
  String _cityName = 'London';

  @override
  void initState() {
    super.initState();
    forecastObject =
        WeatherApi().fetchWeatherForecasWithCity(cityName: _cityName);
    // forecastObject.then((value) => print(value.list![0].weather![0].main));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('openwaethermap'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.my_location),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var tappedName = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return CityScreen();
                }));
                if (tappedName != null) {
                  setState(() {
                    _cityName = tappedName;
                  });
                  forecastObject = WeatherApi()
                      .fetchWeatherForecasWithCity(cityName: _cityName);
                }
              },
              icon: const Icon(Icons.location_city))
        ],
      ),
      body: ListView(
        children: [
          Container(
            child: FutureBuilder<WeatherForecast>(
              future: forecastObject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    const SizedBox(
                      height: 50,
                    ),
                    CityView(
                      snapshot: snapshot,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TempView(snapshot: snapshot),
                    const SizedBox(
                      height: 50,
                    ),
                    DetailView(snapshot: snapshot),
                    const SizedBox(
                      height: 50,
                    ),
                    BottomListView(snapshot: snapshot)
                  ]);
                } else {
                  return const Center(
                      child: SpinKitDoubleBounce(
                    color: Colors.black87,
                    size: 100.0,
                  ));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
