import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class GpsLocation {
  static late final GpsLocation gpsLocation = GpsLocation._internal();
  static late final loc.Location location;

  GpsLocation();

  intLocation() {
    _requestPermission();
    location = loc.Location();
    location.enableBackgroundMode(enable: true);
  }

  getLocation(Function(Position) locationCallback) async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    locationCallback.call(position);
  }

  GpsLocation._internal();

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
