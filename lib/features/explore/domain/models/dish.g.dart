// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DishImpl _$$DishImplFromJson(Map<String, dynamic> json) => _$DishImpl(
      id: json['id'] as String,
      countryId: json['countryId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      history: json['history'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      spiceLevel: (json['spiceLevel'] as num).toInt(),
      dietaryTags: (json['dietaryTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      recommendedPairings: (json['recommendedPairings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$DishImplToJson(_$DishImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryId': instance.countryId,
      'name': instance.name,
      'description': instance.description,
      'history': instance.history,
      'ingredients': instance.ingredients,
      'spiceLevel': instance.spiceLevel,
      'dietaryTags': instance.dietaryTags,
      'recommendedPairings': instance.recommendedPairings,
      'imageUrl': instance.imageUrl,
    };
