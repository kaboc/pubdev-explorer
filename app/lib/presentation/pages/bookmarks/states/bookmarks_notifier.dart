import 'dart:async';

import 'package:async_phase_notifier/async_phase_notifier.dart';
import 'package:collection/collection.dart';

import 'package:pubdev_explorer/common/_common.dart';

export 'package:pubdev_explorer/presentation/pages/bookmarks/states/bookmarks_state.dart';

BookmarksRepository get _repository => bookmarksRepositoryPot();
PackageCaches get _packageCaches => packageCachesPot();

class BookmarksNotifier extends AsyncPhaseNotifier<BookmarksState> {
  BookmarksNotifier() : super(const BookmarksState()) {
    fetchBookmarks();
  }

  DateTime? _lastAt;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void onSearchWordsChanged(String text) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(
      Duration(milliseconds: text.isEmpty ? 0 : 500),
      () {
        final spaceSeparated =
            text.replaceAll(RegExp(r'[\s!-/:-@[-`{-~]+'), ' ').trim();

        final words = spaceSeparated.isEmpty
            ? <String>[]
            : spaceSeparated.split(' ').map((v) => v.toLowerCase()).toList();

        final data = value.data!;
        if (!const ListEquality<String>().equals(words, data.searchWords)) {
          value = value.copyWith(
            data.copyWith(
              packageNames: {},
              searchWords: words,
            ),
          );

          fetchBookmarks();
        }
      },
    );
  }

  Future<void> _fetch({DateTime? before}) async {
    if (value.isWaiting) {
      return;
    }

    await runAsync((data) async {
      final packages = data!.searchWords.isEmpty
          ? await _repository.fetch(
              limit: kBookmarksFetchLimit,
              before: before,
            )
          : await _repository.search(
              words: data.searchWords,
              limit: kBookmarksFetchLimit,
              before: before,
            );

      for (final package in packages) {
        _packageCaches[package.name] ??= PackageNotifier(name: package.name);
        _packageCaches[package.name]?.updateWith(package);
      }

      if (packages.isNotEmpty) {
        _lastAt = packages.last.bookmarkedAt;
      }

      return value.data!.copyWith(
        packageNames: {
          ...value.data!.packageNames,
          for (final package in packages) package.name,
        },
        hasMore: packages.length == kBookmarksFetchLimit,
      );
    });
  }

  Future<void> fetchBookmarks() async {
    await _fetch();
  }

  Future<void> fetchNextBookmarks() async {
    if (value.data!.hasMore) {
      await _fetch(before: _lastAt);
    }
  }
}
