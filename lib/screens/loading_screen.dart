import 'package:flutter/material.dart';
import 'package:weather/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getLocationData() async {
    WeatherModel weather = WeatherModel();

    var weatherData = await weather.getWeatherData();

    // forwarding the user to location screen and the data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {return LocationScreen(locationWeather: weatherData,);},
      ),
    );
  }


  // Initiating the main function to get device position and then fetching the live data.

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {

    // Added a simple loader with external library, so that it can take time to fetch user current location

    return const Scaffold(
      body: Center(
          child: SpinKitFadingCube(
            color: Colors.white,
            size: 100.0,
          ),
      )
    );
  }
}
