import 'dart:async';

import 'package:async_phase_notifier/async_phase_notifier.dart';
import 'package:collection/collection.dart';

import 'package:pubdev_explorer/common/_common.dart';

export 'package:pubdev_explorer/presentation/pages/home/states/home_state.dart';

PackagesRepository get _repository => packagesRepositoryPot();
PackageCaches get _packageCaches => packageCachesPot();

class HomeNotifier extends AsyncPhaseNotifier<HomeState> {
  HomeNotifier({Iterable<String>? keywords})
      : isSearch = keywords != null,
        isPublisherSearch = (keywords ?? []).any(
          (w) => w.startsWith('publisher:'),
        ),
        super(HomeState(keywords: keywords)) {
    fetchNames();
  }

  final bool isSearch;
  final bool isPublisherSearch;

  Future<void> onIndexChanged(int index) async {
    final newData = data.copyWith(index: index);
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

  Future<void> fetchNames({Iterable<String>? keywords}) async {
    final prevKeywords = data.keywords;

    if (keywords != null) {
      const equality = DeepCollectionEquality.unordered();
      if (keywords.isEmpty || equality.equals(keywords, prevKeywords)) {
        return;
      }
      value = value.copyWith(
        HomeState(keywords: keywords),
      );
    } else if (!data.hasMore) {
      return;
    }

    if (value.isWaiting) {
      return;
    }

    await update(() async {
      final newPage = data.page + 1;
      final phase = await _repository.fetchPackageNames(
        page: newPage,
        keywords: keywords ?? prevKeywords,
      );

      if (phase case AsyncError()) {
        phase.rethrowError();
      }

      final names = phase.data!;
      for (final name in names) {
        _packageCaches[name] ??= PackageNotifier(name: name);
      }

      return data.copyWith(
        page: newPage,
        hasMore: names.isNotEmpty,
        packageNames: {...data.packageNames, ...names},
      );
    });

    if (!value.isError && data.isLast) {
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
    final notifier = _packageCaches[data.currentPackageName];
    await notifier?.fetchPackage(useCache: true);
  }

  Future<void> restart() async {
    value = const AsyncInitial(HomeState());
    await fetchNames();
  }
}
