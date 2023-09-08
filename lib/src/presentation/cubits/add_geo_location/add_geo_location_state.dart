import 'package:dio/dio.dart';

import '../../../domain/models/responses/geo_address_response.dart';

abstract class AddGeoLocationState {
  final GetGeoAddressResponse? response;

  final DioError? error;

  const AddGeoLocationState({
    this.response,
    this.error,
  });

  List<Object?> get props => [response, error];
}

class AddGeoLocationLoadingState extends AddGeoLocationState {
  const AddGeoLocationLoadingState();
}

class AddGeoLocationSuccessState extends AddGeoLocationState {
  const AddGeoLocationSuccessState({super.response});
}

class AddGeoLocationCompleteSuccessState extends AddGeoLocationState {
  const AddGeoLocationCompleteSuccessState({super.response});
}

class AddGeoLocationErrorState extends AddGeoLocationState {
  const AddGeoLocationErrorState({super.error});
}
