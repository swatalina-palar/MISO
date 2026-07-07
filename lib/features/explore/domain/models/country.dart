import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.freezed.dart';
part 'country.g.dart';

@freezed
class Country with _$Country {
  const factory Country({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
}
