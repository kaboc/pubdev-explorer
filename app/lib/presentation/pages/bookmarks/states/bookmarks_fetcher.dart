import 'package:async_phase_notifier/async_phase_notifier.dart';

import 'package:pubdev_explorer/common/_common.dart';

BookmarksRepository get _repository => bookmarksRepositoryPot();

class BookmarksFetcher extends AsyncPhaseNotifier<List<Package>> {
  BookmarksFetcher() : super([]);

  void fetch({
    required List<String> searchWords,
    required int limit,
    DateTime? before,
  }) {
    runAsync(
      (_) => searchWords.isEmpty
          ? _repository.fetch(
              limit: limit,
              before: before,
            )
          : _repository.search(
              words: searchWords,
              limit: limit,
              before: before,
            ),
    );
  }
}
