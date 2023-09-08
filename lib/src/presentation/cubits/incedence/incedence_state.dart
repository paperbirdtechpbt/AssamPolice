import 'package:dio/dio.dart';

import '../../../domain/models/responses/geo_address_response.dart';

abstract class IncedenceState {
  final GetGeoAddressResponse? response;

  final DioError? error;

  const IncedenceState({
    this.response,
    this.error,
  });

  List<Object?> get props => [response, error];
}

class IncedenceLoadingState extends IncedenceState {
  const IncedenceLoadingState();
}

class IncedenceSuccessState extends IncedenceState {
  const IncedenceSuccessState({super.response});
}

class IncedenceCompleteSuccessState extends IncedenceState {
  const IncedenceCompleteSuccessState({super.response});
}

class IncedenceErrorState extends IncedenceState {
  const IncedenceErrorState({super.error});
}
