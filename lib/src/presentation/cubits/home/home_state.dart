import 'package:dio/dio.dart';

import '../../../domain/models/responses/get_category_response.dart';
import '../../../domain/models/responses/get_district_response.dart';

abstract class HomeState {
  final GetDistrictResponse? response;
  final GetCategoryResponse? categoryResponse;

  final DioError? error;

  const HomeState({
    this.response,
    this.categoryResponse,
    this.error,
  });

  List<Object?> get props => [categoryResponse, response, error];
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class GetDistrictSuccessState extends HomeState {
  const GetDistrictSuccessState({super.response});
}

class GetPoliceStationSuccessState extends HomeState {
  const GetPoliceStationSuccessState({super.response});
}

class GetCategorySuccessState extends HomeState {
  const GetCategorySuccessState({super.categoryResponse});
}

class HomeErrorState extends HomeState {
  const HomeErrorState({super.error});
}

class HomeCategoryErrorState extends HomeState {
  const HomeCategoryErrorState({super.error});
}
