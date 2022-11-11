import 'package:async_phase_notifier/async_phase_notifier.dart';

import 'package:pubdev_explorer/common/_common.dart';

BookmarksRepository get _repository => bookmarksRepositoryPot();

class BookmarkToggler extends AsyncPhaseNotifier<Package> {
  BookmarkToggler() : super(const Package.none());

  void toggle({required Package package}) {
    value = AsyncWaiting(data: package);
    runAsync((_) => _repository.toggleBookmark(package: package));
  }
}
