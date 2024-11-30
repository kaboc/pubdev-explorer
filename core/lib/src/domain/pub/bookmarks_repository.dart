import 'package:async_phase/async_phase.dart';

import 'package:pubdev_explorer_core/src/common/_common.dart';
import 'package:pubdev_explorer_core/src/domain/pub/models/package.dart';
import 'package:pubdev_explorer_core/src/infrastructure/local_db/daos/bookmarks_dao.dart';

BookmarksDao get _dao => localDatabasePot().bookmarksDao;

class BookmarksRepository {
  const BookmarksRepository();

  Future<AsyncPhase<Iterable<Package>>> fetch({
    required int limit,
    DateTime? before,
  }) {
    return AsyncPhase.from(
      () => _dao.fetch(
        limit: limit,
        before: before ?? DateTime.now(),
      ),
      onError: (_, e, s) => Logger.error(e, s),
    );
  }

  Future<AsyncPhase<Iterable<Package>>> search({
    required Iterable<String> words,
    required int limit,
    DateTime? before,
  }) {
    return AsyncPhase.from(
      () => _dao.search(
        words: words,
        limit: limit,
        before: before ?? DateTime.now(),
      ),
      onError: (_, e, s) => Logger.error(e, s),
    );
  }

  Future<AsyncPhase<Package>> toggleBookmark({required Package package}) async {
    final updatedPackage = package.copyWith(
      bookmarked: package.bookmarkedAt == null,
    );

    return AsyncPhase.from(
      () async {
        package.bookmarkedAt == null
            ? await _dao.addOrUpdateBookmark(package: updatedPackage)
            : await _dao.deleteBookmark(package: updatedPackage);
        return updatedPackage;
      },
      onError: (_, e, s) => Logger.error(e, s),
    );
  }
}
