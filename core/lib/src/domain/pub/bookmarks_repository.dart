import 'package:pubdev_explorer_core/src/common/_common.dart';
import 'package:pubdev_explorer_core/src/domain/pub/models/package.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/daos/bookmarks_dao.dart';

BookmarksDao get _dao => localDatabasePot().bookmarksDao;

class BookmarksRepository {
  const BookmarksRepository();

  Future<List<Package>> fetch({required int limit, DateTime? before}) {
    try {
      return _dao.fetch(
        limit: limit,
        before: before ?? DateTime.now(),
      );
    } on Exception catch (e, s) {
      Logger.error(e, s);
      rethrow;
    }
  }

  Future<List<Package>> search({
    required List<String> words,
    required int limit,
    DateTime? before,
  }) {
    try {
      return _dao.search(
        words: words,
        limit: limit,
        before: before ?? DateTime.now(),
      );
    } on Exception catch (e, s) {
      Logger.error(e, s);
      rethrow;
    }
  }

  Future<Package> toggleBookmark({required Package package}) async {
    final updatedPackage = package.copyWith(
      bookmarked: package.bookmarkedAt == null,
    );

    try {
      package.bookmarkedAt == null
          ? await _dao.addOrUpdateBookmark(package: updatedPackage)
          : await _dao.deleteBookmark(package: updatedPackage);

      return updatedPackage;
    } on Exception catch (e, s) {
      Logger.error(e, s);
      rethrow;
    }
  }
}
