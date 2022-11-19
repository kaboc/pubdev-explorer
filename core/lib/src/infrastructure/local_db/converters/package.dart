import 'package:drift/drift.dart';

import 'package:pubdev_explorer_core/src/common/_common.dart';
import 'package:pubdev_explorer_core/src/domain/pub/_pub.dart';

extension PackageToCompanion on Package {
  PackagesTableCompanion get asCompanion {
    return PackagesTableCompanion.insert(
      name: name,
      description: description,
      latest: latest.version,
      latestAt: Value(latest.publishedAt),
      preRelease: Value(preRelease?.version),
      preReleaseAt: Value(preRelease?.publishedAt),
      sdks: sdks.toCommaSeparatedNames(),
      platforms: platforms.toCommaSeparatedNames(),
      publisher: publisher,
      points: points,
      maxPoints: maxPoints,
      likes: likes,
      popularity: popularity,
      savedAt: DateTime.now(),
    );
  }
}

extension PackageToBookmarkCompanion on Package {
  BookmarksTableCompanion get asBookmarkCompanion {
    return BookmarksTableCompanion.insert(
      name: name,
      createdAt: DateTime.now(),
    );
  }
}

extension DataToPackage on PackagesWithBookmarkData {
  Package get asPackage {
    return Package(
      name: name,
      description: description,
      latest: Version(version: latest, publishedAt: latestAt),
      preRelease: preRelease == null
          ? null
          : Version(version: preRelease!, publishedAt: preReleaseAt),
      sdks: Sdk.values.fromCommaSeparatedNames(sdks),
      platforms: Platform.values.fromCommaSeparatedNames(platforms),
      publisher: publisher,
      points: points,
      maxPoints: maxPoints,
      likes: likes,
      popularity: popularity,
      savedAt: savedAt,
      bookmarkedAt: bookmarkedAt,
    );
  }
}
