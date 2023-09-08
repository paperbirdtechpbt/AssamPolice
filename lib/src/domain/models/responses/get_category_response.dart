import 'package:equatable/equatable.dart';

import '../data/category.dart';

class GetCategoryResponse {
  GetCategoryResponse({
    this.status,
    this.message,
    this.data,
  });

  GetCategoryResponse.fromMap(Map<String, dynamic> json) {
    status = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? CategoryData.fromMap(json['data']) : null;
  }

  String? status;
  String? message;
  CategoryData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = status;
    map['message'] = message;
    return map;
  }
}

class CategoryData extends Equatable {
  CategoryData({
    required this.listCategory,
  });

  final List<Category> listCategory;

  factory CategoryData.fromMap(Map<String, dynamic> map) {
    return CategoryData(
      listCategory: List<Category>.from(
        map['categoryList'].map<Category>(
          (x) => Category.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [listCategory];
}
