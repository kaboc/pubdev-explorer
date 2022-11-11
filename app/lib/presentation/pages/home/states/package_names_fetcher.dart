import 'package:async_phase_notifier/async_phase_notifier.dart';

import 'package:pubdev_explorer/common/_common.dart';

PackagesRepository get _repository => packagesRepositoryPot();

class PackageNamesFetcher extends AsyncPhaseNotifier<List<String>> {
  PackageNamesFetcher() : super([]);

  void fetch({required int page}) {
    runAsync((_) => _repository.fetchPackageNames(page: page));
  }
}
