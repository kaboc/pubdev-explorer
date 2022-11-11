import 'package:pubdev_explorer_domain/src/common/_common.dart';
import 'package:pubdev_explorer_domain/src/domain/pub/_pub.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/pub_api/converters/package.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/pub_api/mock/package_basics.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/pub_api/mock/package_metrics.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/pub_api/mock/package_names.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/pub_api/models/package_basics.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/pub_api/models/package_metrics.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/pub_api/models/package_names.dart';

const _kNameLimit = 10;

class MockPubDao implements PubDao {
  @override
  Future<List<String>> fetchPackageNames({int page = 1}) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    final maxLen = kMockPackageNames.length;
    final start = (page - 1) * _kNameLimit;
    var end = start + _kNameLimit;
    if (end > maxLen) {
      end = maxLen;
    }
    final names = start < maxLen
        ? kMockPackageNames.getRange(start, end).toList()
        : <JsonMap>[];

    return PackageNames.fromJson({'packages': names})
        .list
        .map((v) => v.name)
        .toList();
  }

  @override
  Future<Package> fetchPackage({required String name}) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    final results = await Future.wait([
      _fetchPackageBasics(name),
      _fetchPackageDetails(name),
    ]);
    final basic = results.first as PackageBasics;
    final details = results.last as PackageDetails;

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
