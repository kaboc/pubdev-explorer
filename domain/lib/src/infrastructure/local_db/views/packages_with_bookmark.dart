import 'package:drift/drift.dart';

import 'package:pubdev_explorer_domain/src/infrastructure/local_db/tables/bookmarks_table.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/local_db/tables/packages_table.dart';

abstract class PackagesWithBookmark extends View {
  PackagesTable get packages;

  BookmarksTable get bookmarks;

  Expression<DateTime> get bookmarkedAt => bookmarks.createdAt;

  @override
  Query<HasResultSet, Object?> as() => select([
        packages.name,
        packages.description,
        packages.latest,
        packages.latestAt,
        packages.preRelease,
        packages.preReleaseAt,
        packages.sdks,
        packages.platforms,
        packages.publisher,
        packages.points,
        packages.maxPoints,
        packages.likes,
        packages.popularity,
        packages.savedAt,
        bookmarkedAt,
      ]).from(packages).join([
        leftOuterJoin(bookmarks, bookmarks.name.equalsExp(packages.name)),
      ]);
}
