import 'package:flutter/foundation.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';

export 'package:pubdev_explorer/presentation/pages/home/states/home_state.dart';

PackageNamesFetcher get _packageNamesFetcher => packageNamesFetcherPot();
PackageFetcher get _packageFetcher => packageFetcherPot();
BookmarkToggler get _bookmarkToggler => bookmarkTogglerPot();

class HomeNotifier extends ValueNotifier<HomeState> {
  HomeNotifier() : super(const HomeState()) {
    final remove1 = _packageNamesFetcher.listen(_onPackageNamesFetched);
    final remove2 = _packageFetcher.listen(_onPackageFetched);
    final remove3 = _bookmarkToggler.listen(_onBookmarkToggled);

    _removeListeners = () {
      remove1();
      remove2();
      remove3();
    };

    fetchList();
  }

  late final void Function() _removeListeners;

  @override
  void dispose() {
    _removeListeners();
    super.dispose();
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

//======================================================================

/// Private extension containing listeners
/// triggered by updates in other notifiers.
extension on HomeNotifier {
  void _onPackageNamesFetched(AsyncPhase<List<String>> phase) {
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

  void _onPackageFetched(AsyncPhase<Package> phase) {
    value = value.copyWith(
      packagePhases: value.packagePhases.copyAndReplace(
        packagePhase: phase,
      ),
    );
  }

  void _onBookmarkToggled(AsyncPhase<Package> phase) {
    value = value.copyWith(
      packagePhases: value.packagePhases.copyAndReplace(
        packagePhase: phase,
      ),
    );
  }
}
