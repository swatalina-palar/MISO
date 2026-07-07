import 'package:freezed_annotation/freezed_annotation.dart';

part 'dish.freezed.dart';
part 'dish.g.dart';

@freezed
class Dish with _$Dish {
  const factory Dish({
    required String id,
    required String countryId,
    required String name,
    required String description,
    required String history,
    required List<String> ingredients,
    required int spiceLevel, // 0 to 5
    required List<String> dietaryTags, // e.g., 'Vegetarian', 'Gluten-Free'
    required List<String> recommendedPairings,
    required String imageUrl,
  }) = _Dish;

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
}
