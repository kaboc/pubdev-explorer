import 'package:flutter/foundation.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';

export 'package:pubdev_explorer/presentation/pages/home/states/home_state.dart';

PackageNamesFetcher get _packageNamesFetcher => packageNamesFetcherPot();

PackageFetcher get _packageFetcher => packageFetcherPot();

BookmarkToggler get _bookmarkToggler => bookmarkTogglerPot();

class HomeNotifier extends ValueNotifier<HomeState> {
  HomeNotifier() : super(const HomeState()) {
    _packageNamesFetcher.addListener(_onPackageNamesFetched);
    _packageFetcher.addListener(_onPackageFetched);
    _bookmarkToggler.addListener(_onBookmarkToggled);
    fetchList();
  }

  @override
  void dispose() {
    _packageNamesFetcher.removeListener(_onPackageNamesFetched);
    _packageFetcher.removeListener(_onPackageFetched);
    _bookmarkToggler.removeListener(_onBookmarkToggled);
    super.dispose();
  }

  void _onPackageNamesFetched() {
    final phase = _packageNamesFetcher.value;
    if (phase.isComplete) {
      if (phase.data!.isEmpty) {
        value = value.copyWith(endReached: true);
      } else {
        final packagePhases = List.of(value.packagePhases);
        for (final name in phase.data!) {
          if (packagePhases.indexWhere((v) => v.data!.name == name) < 0) {
            packagePhases.add(
              AsyncInitial(Package(name: name)),
            );
          }
        }

        value = value.copyWith(
          page: value.page + 1,
          packagePhases: packagePhases,
        );

        if (value.isLast) {
          // Another fetch is necessary because the length of
          // the map hasn't changed, meaning all the fetched
          // packages already existed in there.
          fetchList();
          return;
        }
      }
    }

    fetchPackage(currentPackage: value.currentPackage);
  }

  void _onPackageFetched() {
    value = value.copyWith(
      packagePhases: value.packagePhases.copyAndReplace(
        packagePhase: _packageFetcher.value,
      ),
    );
  }

  void _onBookmarkToggled() {
    value = value.copyWith(
      packagePhases: value.packagePhases.copyAndReplace(
        packagePhase: _bookmarkToggler.value,
      ),
    );
  }

  void onIndexChanged(int index) {
    value = value.copyWith(index: index);

    if (value.isIndexOutOfRange && !value.isFirst) {
      return;
    }
    if (value.isLast) {
      fetchList();
    } else {
      fetchPackage(currentPackage: value.currentPackage);
    }
  }

  void fetchList() {
    if (value.endReached) {
      return;
    }

    if (_packageNamesFetcher.value.isWaiting) {
      Future<void>.delayed(const Duration(seconds: 1), fetchList);
      return;
    }

    _packageNamesFetcher.fetch(page: value.page + 1);
  }

  void fetchPackage({Package? currentPackage, bool fromWeb = false}) {
    if (currentPackage != null && (currentPackage.isEmpty || fromWeb)) {
      _packageFetcher.fetch(currentPackage: currentPackage, fromWeb: fromWeb);
    }
  }

  void toggleBookmark({required Package package}) {
    _bookmarkToggler.toggle(package: package);
  }

  void restart() {
    value = const HomeState();
    fetchList();
  }
}
