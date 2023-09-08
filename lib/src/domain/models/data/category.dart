import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int? categoryId;
  final String? categoryName;
  final String? icon;

  const Category({
    required this.categoryId,
    required this.categoryName,
    required this.icon,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : null,
      categoryName:
          map['categoryName'] != null ? map['categoryName'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      categoryId,
      categoryName,
      icon,
    ];
  }
}
