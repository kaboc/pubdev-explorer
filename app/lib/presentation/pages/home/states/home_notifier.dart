import 'dart:async';

import 'package:async_phase_notifier/async_phase_notifier.dart';

import 'package:pubdev_explorer/common/_common.dart';

export 'package:pubdev_explorer/presentation/pages/home/states/home_state.dart';

PackagesRepository get _repository => packagesRepositoryPot();
PackageCaches get _packageCaches => packageCachesPot();

class HomeNotifier extends AsyncPhaseNotifier<HomeState> {
  HomeNotifier({String? keywords})
      : isSearch = keywords != null,
        super(HomeState(keywords: keywords)) {
    fetchNames();
  }

  final bool isSearch;

  Future<void> onIndexChanged(int index) async {
    final newData = value.data!.copyWith(index: index);
    value = value.copyWith(newData);

    if (newData.isIndexOutOfRange) {
      return;
    }
    if (newData.isLast) {
      unawaited(
        fetchNames(),
      );
    }

    await _fetchCurrentPackage();
  }

  Future<void> fetchNames({String? keywords}) async {
    final data = value.data!;
    final trimmed = keywords?.trim();

    if (trimmed != null) {
      if (trimmed.isEmpty || trimmed == data.keywords) {
        return;
      }
      value = value.copyWith(
        HomeState(keywords: trimmed),
      );
    } else if (!data.hasMore) {
      return;
    }

    if (value.isWaiting) {
      return;
    }

    await runAsync((data) async {
      final newPage = data!.page + 1;
      final names = await _repository.fetchPackageNames(
        page: newPage,
        keywords: trimmed ?? data.keywords,
      );
      final newData = value.data!;

      for (final name in names) {
        _packageCaches[name] ??= PackageNotifier(name: name);
      }

      return newData.copyWith(
        page: newPage,
        hasMore: names.isNotEmpty,
        packageNames: {...newData.packageNames, ...names},
      );
    });

    final newData = value.data!;
    if (!value.isError && newData.isLast) {
      // Another fetch is necessary if the current index is
      // still the end because it means all the fetched packages
      // were already in the existing list.
      unawaited(
        fetchNames(),
      );
    }

    await _fetchCurrentPackage();
  }

  Future<void> _fetchCurrentPackage() async {
    final notifier = _packageCaches[value.data!.currentPackageName];
    await notifier?.fetchPackage(useCache: true);
  }

  Future<void> restart() async {
    value = const AsyncInitial(HomeState());
    await fetchNames();
  }
}
