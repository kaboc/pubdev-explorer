import 'package:async_phase_notifier/async_phase_notifier.dart';

import 'package:pubdev_explorer/common/_common.dart';

typedef PackageCaches = Map<String, PackageNotifier>;

PackagesRepository get _repository => packagesRepositoryPot();
BookmarksRepository get _bookmarksRepository => bookmarksRepositoryPot();

class PackageNotifier extends AsyncPhaseNotifier<Package> {
  PackageNotifier({required String name}) : super(Package(name: name));

  void updateWith(Package package) {
    value = AsyncComplete(package);
  }

  Future<void> fetchPackage({required bool useCache}) async {
    if (useCache && !data.isEmpty) {
      return;
    }

    await update(() async {
      final phase = await _repository.fetchPackage(
        name: data.name,
        cacheDuration: kPackageCacheDuration,
        useCache: useCache,
      );

      if (phase case AsyncError()) {
        phase.rethrowError();
      }
      return phase.data!;
    });
  }

  Future<void> toggleBookmark() async {
    if (data.isEmpty) {
      return;
    }

    await update(() async {
      final phase = await _bookmarksRepository.toggleBookmark(package: data);

      if (phase case AsyncError()) {
        phase.rethrowError();
      }
      return phase.data!;
    });
  }
}
