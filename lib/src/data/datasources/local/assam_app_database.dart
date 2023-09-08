import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../domain/models/geo_location.dart';
import 'converters/source_type_converter.dart';
import 'dao/my_geoLocation.dart';


part 'assam_app_database.g.dart';// the generated code will be there

@TypeConverters([SourceTypeConverter])
@Database(version: 1, entities: [GeoLocation])
abstract class AssamAppDatabase extends FloorDatabase {
  MyGeoLocationDao get geoLocationDao;
}


