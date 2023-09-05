import 'dart:async';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';

export 'package:pubdev_explorer/presentation/pages/bookmarks/states/bookmarks_state.dart';

BookmarksFetcher get _fetcher => bookmarksFetcherPot();
BookmarkToggler get _toggler => bookmarkTogglerPot();
PackageFetcher get _packageFetcher => packageFetcherPot();

class BookmarksNotifier extends ValueNotifier<BookmarksState> {
  BookmarksNotifier() : super(const BookmarksState()) {
    final remove1 = _fetcher.listenFor(onComplete: _onFetched);
    final remove2 = _toggler.listen(_onToggled);
    final remove3 = _packageFetcher.listen(_onPackageFetched);

    _removeListeners = () {
      remove1();
      remove2();
      remove3();
    };

    fetchBookmarks();
  }

  late final void Function() _removeListeners;

  DateTime? _currentLastAt;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _removeListeners();
    super.dispose();
  }

  void onSearchWordsChanged(String text) {
    _debounceTimer?.cancel();

    if (text.isEmpty) {
      _searchBookmarks(text);
    } else {
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        _searchBookmarks(text);
      });
    }
  }

  void _searchBookmarks(String text) {
    final spaceSeparated =
        text.replaceAll(RegExp(r'[\s!-/:-@[-`{-~]+'), ' ').trim();

    final words = spaceSeparated.isEmpty
        ? <String>[]
        : spaceSeparated.split(' ').map((v) => v.toLowerCase()).toList();

    if (!const ListEquality<String>().equals(words, value.searchWords)) {
      value = value.copyWith(
        packagePhases: [],
        searchWords: words,
      );

      fetchBookmarks();
    }
  }

  Future<void> fetchBookmarks() async {
    if (!_fetcher.value.isWaiting) {
      _fetcher.fetch(
        searchWords: value.searchWords,
        limit: kBookmarksFetchLimit + 1,
      );
    }
  }

  Future<void> fetchNextBookmarks() async {
    if (!_fetcher.value.isWaiting && value.hasMore) {
      _fetcher.fetch(
        searchWords: value.searchWords,
        limit: kBookmarksFetchLimit + 1,
        before: _currentLastAt,
      );
    }
  }

  void fetchPackage({required Package package}) {
    _packageFetcher.fetch(currentPackage: package, fromWeb: true);
  }

  void toggleBookmark({required Package package}) {
    _toggler.toggle(package: package);
  }
}

//======================================================================

/// Private extension containing listeners
/// triggered by updates in other notifiers.
extension on BookmarksNotifier {
  void _onFetched(List<Package> packages) {
    final hasMore = packages.length > kBookmarksFetchLimit;
    if (hasMore) {
      packages.removeLast();
      _currentLastAt = packages.last.bookmarkedAt;
    }

    value = value.copyWith(
      packagePhases: [
        ...value.packagePhases,
        for (final package in packages) AsyncComplete(package),
      ],
      hasMore: hasMore,
    );
  }

  void _onToggled(AsyncPhase<Package> phase) {
    value = value.copyWith(
      packagePhases: value.packagePhases.copyAndReplace(
        packagePhase: phase,
      ),
    );
  }

  void _onPackageFetched(AsyncPhase<Package> phase) {
    value = value.copyWith(
      packagePhases: value.packagePhases.copyAndReplace(
        packagePhase: phase,
      ),
    );
  }
}
