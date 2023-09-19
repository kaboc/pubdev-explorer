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
    final package = value.data!;
    if (useCache && !package.isEmpty) {
      return;
    }

    await runAsync(
      (_) => _repository.fetchPackage(
        name: value.data!.name,
        cacheDuration: kPackageCacheDuration,
        useCache: useCache,
      ),
    );
  }

  Future<void> toggleBookmark() async {
    final package = value.data!;
    if (!package.isEmpty) {
      await runAsync(
        (_) => _bookmarksRepository.toggleBookmark(package: package),
      );
    }
  }
}
