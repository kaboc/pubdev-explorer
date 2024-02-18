import 'package:pubdev_explorer_core/src/common/_common.dart';
import 'package:pubdev_explorer_core/src/domain/pub/_pub.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/converters/package.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/mock/package_basics.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/mock/package_metrics.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/mock/package_names.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/models/package_basics.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/models/package_metrics.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/models/package_names.dart';

const _kNameLimit = 10;

class MockPubDao implements PubDao {
  @override
  Future<Iterable<String>> fetchPackageNames({
    int page = 1,
    Iterable<String>? keywords,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    if (keywords != null) {
      throw UnimplementedError();
    }

    final maxLen = kMockPackageNames.length;
    final start = (page - 1) * _kNameLimit;
    var end = start + _kNameLimit;
    if (end > maxLen) {
      end = maxLen;
    }
    final names = start < maxLen
        ? kMockPackageNames.getRange(start, end).toList()
        : <JsonMap>[];

    return PackageNames.fromJson({'packages': names}).list.map((v) => v.name);
  }

  @override
  Future<Package> fetchPackage({required String name}) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    final results = await (
      _fetchPackageBasics(name),
      _fetchPackageDetails(name),
    ).wait;

    final basic = results.$1;
    final details = results.$2;

    return basic.asPackage.copyWith(
      sdks: details.tags.sdks,
      platforms: details.tags.platforms,
      publisher: details.tags.publisher,
      points: details.grantedPoints,
      maxPoints: details.maxPoints,
      likes: details.likeCount,
      popularity: details.popularityScore,
    );
  }

  Future<PackageBasics> _fetchPackageBasics(String name) async {
    final basics = kMockPackageBasics[name];
    if (basics == null) {
      throw Exception();
    }
    return PackageBasics.fromJson(basics);
  }

  Future<PackageDetails> _fetchPackageDetails(String name) async {
    final basics = kMockPackageMetrics[name];
    if (basics == null) {
      throw Exception();
    }
    return PackageMetrics.fromJson(basics).details;
  }
}
