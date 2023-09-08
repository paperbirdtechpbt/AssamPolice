import 'package:floor/floor.dart';

import '../../../../domain/models/geo_location.dart';
import '../../../../utils/constants/strings.dart';

@dao
abstract class MyGeoLocationDao {
  @Query('SELECT * FROM $geoLocationTableName')
  Future<List<GeoLocation>> getAllGeoLocation();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveGeoLocation(GeoLocation saveGeoLocation);

  @delete
  Future<void> deleteGeoLocation(GeoLocation geoLocation);

  @Query(
      'UPDATE FloorUser SET latitude = :latitude , longitude = :longitude  WHERE id != :id')
  Future<void> updateGeoLocation(int id, double latitude, double longitude);

  @Query('select *  from $geoLocationTableName ORDER BY id DESC LIMIT 1;')
  Future<GeoLocation?> getLastGeoLocation();

  @Query('delete from $geoLocationTableName')
  Future<GeoLocation?> deleteData();
}
