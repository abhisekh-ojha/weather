import 'package:geolocator/geolocator.dart';

// The main function of this file is to fetch user position

class Location {

  var latitude;
  var longitude;


  Future <void> getLatitudeLongitude() async {

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    try{
      Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);

      latitude = position.latitude;
      longitude = position.longitude;
    }
    catch (e){
      print(e);
    }
  }


}