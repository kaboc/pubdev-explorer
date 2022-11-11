import 'package:pubdev_explorer_domain/src/common/_common.dart';
import 'package:pubdev_explorer_domain/src/domain/pub/_pub.dart';
import 'package:pubdev_explorer_domain/src/infrastructure/local_db/daos/bookmarks_dao.dart';

BookmarksDao get _dao => localDatabasePot().bookmarksDao;

class BookmarksRepository {
  Future<List<Package>> fetch({required int limit, DateTime? before}) {
    return _dao.fetch(
      limit: limit,
      before: before ?? DateTime.now(),
    );
  }

  Future<List<Package>> search({
    required List<String> words,
    required int limit,
    DateTime? before,
  }) {
    return _dao.search(
      words: words,
      limit: limit,
      before: before ?? DateTime.now(),
    );
  }

  Future<Package> toggleBookmark({required Package package}) async {
    final updatedPackage = package.copyWith(
      bookmarked: package.bookmarkedAt == null,
    );

    package.bookmarkedAt == null
        ? await _dao.addOrUpdateBookmark(package: updatedPackage)
        : await _dao.deleteBookmark(package: updatedPackage);

    return updatedPackage;
  }
}
