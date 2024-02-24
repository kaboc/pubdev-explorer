// ignore_for_file: library_private_types_in_public_api

import 'package:collection/collection.dart';

import 'package:pubdev_explorer_core/src/common/_common.dart';
import 'package:pubdev_explorer_core/src/domain/pub/_pub.dart';

extension type const PackageMetrics._(JsonMap json) {
  const PackageMetrics.fromJson(this.json);

  PackageDetails get details => PackageDetails(
        switch (json) {
          {'score': final JsonMap score} => score,
          _ => {},
        },
      );
}

extension type const PackageDetails(JsonMap json) {
  int get grantedPoints => switch (json) {
        {'grantedPoints': final int grantedPoints} => grantedPoints,
        _ => 0,
      };

  int get maxPoints => switch (json) {
        {'maxPoints': final int maxPoints} => maxPoints,
        _ => 0,
      };

  int get likeCount => switch (json) {
        {'likeCount': final int likeCount} => likeCount,
        _ => 0,
      };

  double get popularityScore => switch (json) {
        {'popularityScore': final double popularityScore} => popularityScore,
        _ => 0.0,
      };

  _Tags get tags => _Tags(
        switch (json) {
          {'tags': final List<Object?> tags} => tags.whereType<String>(),
          _ => [],
        },
      );
}

extension type const _Tags(Iterable<String> list) {
  Iterable<Sdk> get sdks => Sdk.values.fromNames(
        list.where((v) => v.startsWith('sdk:')).map((v) => v.substring(4)),
      );

  Iterable<Platform> get platforms => Platform.values.fromNames(
        list.where((v) => v.startsWith('platform:')).map((v) => v.substring(9)),
      );

  String? get publisher =>
      list.firstWhereOrNull((v) => v.startsWith('publisher:'))?.substring(10);
}
