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
    _fetcher.addListener(_onFetched);
    _toggler.addListener(_onToggled);
    _packageFetcher.addListener(_onPackageFetched);

    _fetchBookmarks();
  }

  void Function()? onFirstFetchComplete;
  DateTime? _currentLastAt;
  bool _hasMore = true;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();

    _fetcher.removeListener(_onFetched);
    _toggler.removeListener(_onToggled);
    _packageFetcher.removeListener(_onPackageFetched);

    super.dispose();
  }

  void _onFetched() {
    final phase = _fetcher.value;
    if (phase.isComplete) {
      final packages = phase.data!;
      if (packages.length > kBookmarksFetchLimit) {
        packages.removeAt(kBookmarksFetchLimit);
        _currentLastAt = packages.last.bookmarkedAt;
      } else {
        _hasMore = false;
      }

      value = value.copyWith(
        packagePhases: [
          ...value.packagePhases,
          for (final package in packages) AsyncComplete(package),
        ],
      );

      if (value.packagePhases.length <= kBookmarksFetchLimit) {
        onFirstFetchComplete?.call();
      }
    }
  }

  void _onToggled() {
    final phase = _toggler.value;
    if (phase.isComplete) {
      value = value.copyWith(
        packagePhases: value.packagePhases.copyAndReplace(
          packagePhase: phase,
        ),
      );
    }
  }

  void _onPackageFetched() {
    value = value.copyWith(
      packagePhases: value.packagePhases.copyAndReplace(
        packagePhase: _packageFetcher.value,
      ),
    );
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

  void _fetchBookmarks() {
    _currentLastAt = null;
    _hasMore = true;
    fetchNextBookmarks();
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

      _fetchBookmarks();
    }
  }

  void fetchNextBookmarks() {
    if (!_fetcher.value.isWaiting && _hasMore) {
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
