import 'package:flutter/foundation.dart';

import 'package:async_phase_notifier/async_phase.dart';

import 'package:pubdev_explorer/common/_common.dart';

PackagesRepository get _repository => packagesRepositoryPot();
BookmarksRepository get _bookmarksRepository => bookmarksRepositoryPot();

class PackagesNotifier extends ValueNotifier<Map<String, AsyncPhase<Package>>> {
  PackagesNotifier() : super({});

  Future<void> fetchPackage({
    required String name,
    required bool useCache,
  }) async {
    final phase = value[name];
    final package = phase?.data ?? Package(name: name);
    if (useCache && !package.isEmpty) {
      return;
    }

    value = Map.of(value)..[name] = AsyncWaiting(package);

    final newPhase = await AsyncPhase.from(
      fallbackData: package,
      () => _repository.fetchPackage(
        name: name,
        cacheDuration: kPackageCacheDuration,
        useCache: useCache,
      ),
    );

    value = Map.of(value)..[name] = newPhase;
  }

  void addToList(List<Package> packages) {
    value = {
      ...value,
      for (final package in packages) package.name: AsyncComplete(package),
    };
  }

  Future<void> toggleBookmark({required Package? package}) async {
    if (package == null) {
      return;
    }

    // It is not necessary to change the phase to AsyncWaiting
    // as toggling a bookmark completes instantly.
    final newPhase = await AsyncPhase.from(
      fallbackData: package,
      () => _bookmarksRepository.toggleBookmark(package: package),
    );

    value = Map.of(value)..[package.name] = newPhase;
  }
}
