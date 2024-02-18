// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, strict_raw_type, duplicate_ignore

part of '../../../../infrastructure/pub_api/models/package_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageMetrics _$PackageMetricsFromJson(Map<String, dynamic> json) =>
    PackageMetrics(
      details: json['score'] == null
          ? const PackageDetails()
          : PackageDetails.fromJson(json['score'] as Map<String, dynamic>),
    );

PackageDetails _$PackageDetailsFromJson(Map<String, dynamic> json) =>
    PackageDetails(
      grantedPoints: json['grantedPoints'] as int? ?? 0,
      maxPoints: json['maxPoints'] as int? ?? 0,
      likeCount: json['likeCount'] as int? ?? 0,
      popularityScore: (json['popularityScore'] as num?)?.toDouble() ?? 0.0,
      tags: json['tags'] == null
          ? const _Tags()
          : PackageDetails._tagsFromJson(json['tags'] as List),
    );

Map<String, dynamic> _$PackageDetailsToJson(PackageDetails instance) =>
    <String, dynamic>{
      'grantedPoints': instance.grantedPoints,
      'maxPoints': instance.maxPoints,
      'likeCount': instance.likeCount,
      'popularityScore': instance.popularityScore,
      'tags': instance.tags,
    };

_Tags _$TagsFromJson(Map<String, dynamic> json) => _Tags(
      sdks: json['sdks'] == null
          ? const []
          : _Tags._sdksFromJson(json['sdks'] as List),
      platforms: json['platforms'] == null
          ? const []
          : _Tags._platformsFromJson(json['platforms'] as List),
      publisher: json['publisher'] as String? ?? '',
    );

Map<String, dynamic> _$TagsToJson(_Tags instance) => <String, dynamic>{
      'sdks': instance.sdks.map((e) => _$SdkEnumMap[e]!).toList(),
      'platforms':
          instance.platforms.map((e) => _$PlatformEnumMap[e]!).toList(),
      'publisher': instance.publisher,
    };

const _$SdkEnumMap = {
  Sdk.dart: 'dart',
  Sdk.flutter: 'flutter',
};

const _$PlatformEnumMap = {
  Platform.android: 'android',
  Platform.ios: 'ios',
  Platform.windows: 'windows',
  Platform.linux: 'linux',
  Platform.macos: 'macos',
  Platform.web: 'web',
};
