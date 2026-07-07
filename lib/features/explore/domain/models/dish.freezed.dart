// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dish.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Dish _$DishFromJson(Map<String, dynamic> json) {
  return _Dish.fromJson(json);
}

/// @nodoc
mixin _$Dish {
  String get id => throw _privateConstructorUsedError;
  String get countryId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get history => throw _privateConstructorUsedError;
  List<String> get ingredients => throw _privateConstructorUsedError;
  int get spiceLevel => throw _privateConstructorUsedError; // 0 to 5
  List<String> get dietaryTags =>
      throw _privateConstructorUsedError; // e.g., 'Vegetarian', 'Gluten-Free'
  List<String> get recommendedPairings => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DishCopyWith<Dish> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DishCopyWith<$Res> {
  factory $DishCopyWith(Dish value, $Res Function(Dish) then) =
      _$DishCopyWithImpl<$Res, Dish>;
  @useResult
  $Res call(
      {String id,
      String countryId,
      String name,
      String description,
      String history,
      List<String> ingredients,
      int spiceLevel,
      List<String> dietaryTags,
      List<String> recommendedPairings,
      String imageUrl});
}

/// @nodoc
class _$DishCopyWithImpl<$Res, $Val extends Dish>
    implements $DishCopyWith<$Res> {
  _$DishCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? countryId = null,
    Object? name = null,
    Object? description = null,
    Object? history = null,
    Object? ingredients = null,
    Object? spiceLevel = null,
    Object? dietaryTags = null,
    Object? recommendedPairings = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      countryId: null == countryId
          ? _value.countryId
          : countryId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      history: null == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spiceLevel: null == spiceLevel
          ? _value.spiceLevel
          : spiceLevel // ignore: cast_nullable_to_non_nullable
              as int,
      dietaryTags: null == dietaryTags
          ? _value.dietaryTags
          : dietaryTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendedPairings: null == recommendedPairings
          ? _value.recommendedPairings
          : recommendedPairings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DishImplCopyWith<$Res> implements $DishCopyWith<$Res> {
  factory _$$DishImplCopyWith(
          _$DishImpl value, $Res Function(_$DishImpl) then) =
      __$$DishImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String countryId,
      String name,
      String description,
      String history,
      List<String> ingredients,
      int spiceLevel,
      List<String> dietaryTags,
      List<String> recommendedPairings,
      String imageUrl});
}

/// @nodoc
class __$$DishImplCopyWithImpl<$Res>
    extends _$DishCopyWithImpl<$Res, _$DishImpl>
    implements _$$DishImplCopyWith<$Res> {
  __$$DishImplCopyWithImpl(_$DishImpl _value, $Res Function(_$DishImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? countryId = null,
    Object? name = null,
    Object? description = null,
    Object? history = null,
    Object? ingredients = null,
    Object? spiceLevel = null,
    Object? dietaryTags = null,
    Object? recommendedPairings = null,
    Object? imageUrl = null,
  }) {
    return _then(_$DishImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      countryId: null == countryId
          ? _value.countryId
          : countryId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      history: null == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      spiceLevel: null == spiceLevel
          ? _value.spiceLevel
          : spiceLevel // ignore: cast_nullable_to_non_nullable
              as int,
      dietaryTags: null == dietaryTags
          ? _value._dietaryTags
          : dietaryTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recommendedPairings: null == recommendedPairings
          ? _value._recommendedPairings
          : recommendedPairings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DishImpl implements _Dish {
  const _$DishImpl(
      {required this.id,
      required this.countryId,
      required this.name,
      required this.description,
      required this.history,
      required final List<String> ingredients,
      required this.spiceLevel,
      required final List<String> dietaryTags,
      required final List<String> recommendedPairings,
      required this.imageUrl})
      : _ingredients = ingredients,
        _dietaryTags = dietaryTags,
        _recommendedPairings = recommendedPairings;

  factory _$DishImpl.fromJson(Map<String, dynamic> json) =>
      _$$DishImplFromJson(json);

  @override
  final String id;
  @override
  final String countryId;
  @override
  final String name;
  @override
  final String description;
  @override
  final String history;
  final List<String> _ingredients;
  @override
  List<String> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  @override
  final int spiceLevel;
// 0 to 5
  final List<String> _dietaryTags;
// 0 to 5
  @override
  List<String> get dietaryTags {
    if (_dietaryTags is EqualUnmodifiableListView) return _dietaryTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dietaryTags);
  }

// e.g., 'Vegetarian', 'Gluten-Free'
  final List<String> _recommendedPairings;
// e.g., 'Vegetarian', 'Gluten-Free'
  @override
  List<String> get recommendedPairings {
    if (_recommendedPairings is EqualUnmodifiableListView)
      return _recommendedPairings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendedPairings);
  }

  @override
  final String imageUrl;

  @override
  String toString() {
    return 'Dish(id: $id, countryId: $countryId, name: $name, description: $description, history: $history, ingredients: $ingredients, spiceLevel: $spiceLevel, dietaryTags: $dietaryTags, recommendedPairings: $recommendedPairings, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DishImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.countryId, countryId) ||
                other.countryId == countryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.history, history) || other.history == history) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            (identical(other.spiceLevel, spiceLevel) ||
                other.spiceLevel == spiceLevel) &&
            const DeepCollectionEquality()
                .equals(other._dietaryTags, _dietaryTags) &&
            const DeepCollectionEquality()
                .equals(other._recommendedPairings, _recommendedPairings) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      countryId,
      name,
      description,
      history,
      const DeepCollectionEquality().hash(_ingredients),
      spiceLevel,
      const DeepCollectionEquality().hash(_dietaryTags),
      const DeepCollectionEquality().hash(_recommendedPairings),
      imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DishImplCopyWith<_$DishImpl> get copyWith =>
      __$$DishImplCopyWithImpl<_$DishImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DishImplToJson(
      this,
    );
  }
}

abstract class _Dish implements Dish {
  const factory _Dish(
      {required final String id,
      required final String countryId,
      required final String name,
      required final String description,
      required final String history,
      required final List<String> ingredients,
      required final int spiceLevel,
      required final List<String> dietaryTags,
      required final List<String> recommendedPairings,
      required final String imageUrl}) = _$DishImpl;

  factory _Dish.fromJson(Map<String, dynamic> json) = _$DishImpl.fromJson;

  @override
  String get id;
  @override
  String get countryId;
  @override
  String get name;
  @override
  String get description;
  @override
  String get history;
  @override
  List<String> get ingredients;
  @override
  int get spiceLevel;
  @override // 0 to 5
  List<String> get dietaryTags;
  @override // e.g., 'Vegetarian', 'Gluten-Free'
  List<String> get recommendedPairings;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$DishImplCopyWith<_$DishImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
