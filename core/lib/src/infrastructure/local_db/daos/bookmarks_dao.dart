import 'package:drift/drift.dart';

import 'package:pubdev_explorer_core/src/common/_common.dart';
import 'package:pubdev_explorer_core/src/domain/pub/_pub.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/converters/package.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/tables/bookmarks_table.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/views/packages_with_bookmark.dart';

part '../../../generated/infrastructure/local_db/daos/bookmarks_dao.g.dart';

@DriftAccessor(
  tables: [BookmarksTable],
  views: [PackagesWithBookmark],
)
class BookmarksDao extends DatabaseAccessor<Database> with _$BookmarksDaoMixin {
  BookmarksDao(super.db);

  Future<List<Package>> fetch({
    required int limit,
    required DateTime before,
  }) async {
    final stmt = select(packagesWithBookmark)
      ..orderBy([
        (t) =>
            OrderingTerm(expression: t.bookmarkedAt, mode: OrderingMode.desc),
      ])
      ..limit(limit)
      ..where((t) => t.bookmarkedAt.isSmallerThanValue(before));

    final list = await stmt.get();

    return [for (final data in list) data.asPackage];
  }

  Future<List<Package>> search({
    required List<String> words,
    required int limit,
    required DateTime before,
  }) async {
    if (words.isEmpty) {
      return [];
    }

    final stmt = select(packagesWithBookmark)
      ..orderBy([
        (t) =>
            OrderingTerm(expression: t.bookmarkedAt, mode: OrderingMode.desc),
      ])
      ..limit(limit)
      ..where((t) => t.bookmarkedAt.isSmallerThanValue(before))
      ..where((t) {
        Expression<bool> filter = const Constant(true);
        for (final word in words) {
          filter &= t.name.lower().contains(word) |
              t.description.lower().contains(word) |
              t.publisher.lower().contains(word);
        }
        return filter;
      });

    final list = await stmt.get();

    return [for (final data in list) data.asPackage];
  }

  Future<void> addOrUpdateBookmark({required Package package}) async {
    await into(bookmarksTable)
        .insertOnConflictUpdate(package.asBookmarkCompanion);
  }

  Future<void> deleteBookmark({required Package package}) async {
    final stmt = delete(bookmarksTable)
      ..where((t) => t.name.equals(package.name));
    await stmt.go();
  }
}
