import 'package:async_phase_notifier/async_phase_notifier.dart';

import 'package:pubdev_explorer/common/_common.dart';

export 'package:async_phase_notifier/async_phase.dart';

PackagesRepository get _repository => packagesRepositoryPot();

class PackageFetcher extends AsyncPhaseNotifier<Package> {
  PackageFetcher() : super(const Package.none());

  void fetch({required Package currentPackage, bool fromWeb = false}) {
    value = AsyncWaiting(currentPackage);
    runAsync(
      (_) => _repository.fetchPackage(
        name: currentPackage.name,
        cacheDuration: kPackageCacheDuration,
        fromWeb: fromWeb,
      ),
    );
  }
}
