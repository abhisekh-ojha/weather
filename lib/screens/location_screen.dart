import 'package:flutter/material.dart';
import 'package:weather/screens/city_screen.dart';
import 'package:weather/utilities/constants.dart';
import 'package:weather/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  // used location weather and initialized it so that we can fetch the weather data from loading screen
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String? cityName;
  int? currentTemp;
  String? weatherIcon;
  String? message;

  @override
  void initState() {
    super.initState();
    // this is important, it fetches the location weather data into build state
    UpdateUI(widget.locationWeather);
  }

  void UpdateUI(dynamic weatherData) {
    setState(() {
      // used if statement so that incase weather data is null then we can return error.
      if (weatherData == null) {
        currentTemp = 0;
        weatherIcon = 'Error';
        message = 'Unable to get weather data';
        cityName = '';
        return;
      }
      cityName = weatherData['name'];
      var temp = weatherData['main']['temp'];
      currentTemp = temp.toInt();
      message = weather.getMessage(currentTemp!);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getWeatherData();
                      UpdateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData = await weather.getCityWeather(typedName);
                        UpdateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '$currentTemp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                child: Text(
                  '$message in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
