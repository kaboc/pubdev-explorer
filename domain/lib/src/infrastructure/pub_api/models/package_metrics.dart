// ignore_for_file: library_private_types_in_public_api

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:pubdev_explorer_domain/src/common/_common.dart';
import 'package:pubdev_explorer_domain/src/domain/pub/_pub.dart';

part '../../../generated/infrastructure/pub_api/models/package_metrics.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class PackageMetrics {
  const PackageMetrics({this.details = const PackageDetails()});

  factory PackageMetrics.fromJson(JsonMap json) =>
      _$PackageMetricsFromJson(json);

  @JsonKey(name: 'score')
  final PackageDetails details;
}

@JsonSerializable()
class PackageDetails {
  const PackageDetails({
    this.grantedPoints = 0,
    this.maxPoints = 0,
    this.likeCount = 0,
    this.popularityScore = 0.0,
    this.tags = const _Tags(),
  });

  factory PackageDetails.fromJson(JsonMap json) =>
      _$PackageDetailsFromJson(json);

  final int grantedPoints;
  final int maxPoints;
  final int likeCount;
  final double popularityScore;

  @JsonKey(fromJson: tagsFromJson)
  final _Tags tags;

  JsonMap toJson() => _$PackageDetailsToJson(this);

  static _Tags tagsFromJson(List<Object?> list) {
    final l = List<String>.from(list);

    return _Tags.fromJson({
      'sdks': l
          .where((v) => v.startsWith('sdk:'))
          .map((v) => v.substring(4))
          .toList(),
      'platforms': l
          .where((v) => v.startsWith('platform:'))
          .map((v) => v.substring(9))
          .toList(),
      'publisher':
          l.firstWhereOrNull((v) => v.startsWith('publisher:'))?.substring(10),
    });
  }
}

@JsonSerializable()
class _Tags {
  const _Tags({
    this.sdks = const [],
    this.platforms = const [],
    this.publisher = '',
  });

  factory _Tags.fromJson(JsonMap json) => _$TagsFromJson(json);

  @JsonKey(fromJson: sdksFromJson)
  final List<Sdk> sdks;
  @JsonKey(fromJson: platformsFromJson)
  final List<Platform> platforms;
  final String publisher;

  JsonMap toJson() => _$TagsToJson(this);

  static List<Sdk> sdksFromJson(List<Object?> list) =>
      Sdk.values.fromNames(List<String>.from(list));

  static List<Platform> platformsFromJson(List<Object?> list) =>
      Platform.values.fromNames(List<String>.from(list));
}
