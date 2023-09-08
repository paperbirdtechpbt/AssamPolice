import 'package:dio/dio.dart';

import '../../../domain/models/responses/geo_address_response.dart';

abstract class GeoAddressState {
  final GetGeoAddressResponse? response;

  final DioError? error;

  const GeoAddressState({
    this.response,
    this.error,
  });

  List<Object?> get props => [response, error];
}

class GeoAddressLoadingState extends GeoAddressState {
  const GeoAddressLoadingState();
}

class GeoAddressSuccessState extends GeoAddressState {
  const GeoAddressSuccessState({super.response});
}

class GeoAddressCompleteSuccessState extends GeoAddressState {
  const GeoAddressCompleteSuccessState({super.response});
}

class GeoAddressErrorState extends GeoAddressState {
  const GeoAddressErrorState({super.error});
}
