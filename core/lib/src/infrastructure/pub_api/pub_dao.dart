import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pubdev_explorer_core/src/common/_common.dart';
import 'package:pubdev_explorer_core/src/domain/pub/_pub.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/converters/package.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/models/package_basics.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/models/package_metrics.dart';
import 'package:pubdev_explorer_core/src/infrastructure/pub_api/models/package_names.dart';

class PubDao {
  const PubDao();

  Future<List<String>> fetchPackageNames({int page = 1}) async {
    final uri = Uri.parse(
      '${kPubEndpoint}search'
      '?q=is%3Adart3-compatible+license%3Aosi-approved'
      '&sort=updated&page=$page',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonMap = await jsonDecode(response.body) as JsonMap;
      return PackageNames.fromJson(jsonMap).list.map((v) => v.name).toList();
    }

    throw Exception(response.reasonPhrase);
  }

  Future<Package> fetchPackage({required String name}) async {
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
    final url = '${kPubEndpoint}packages/$name';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonMap = await jsonDecode(response.body) as JsonMap;
      return PackageBasics.fromJson(jsonMap);
    }

    throw Exception(response.reasonPhrase);
  }

  Future<PackageDetails> _fetchPackageDetails(String name) async {
    final url = '${kPubEndpoint}packages/$name/metrics';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonMap = await jsonDecode(response.body) as JsonMap;
      return PackageMetrics.fromJson(jsonMap).details;
    }

    throw Exception(response.reasonPhrase);
  }
}
