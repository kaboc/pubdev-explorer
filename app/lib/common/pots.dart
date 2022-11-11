import 'package:pot/pot.dart';

import 'package:pubdev_explorer_domain/pubdev_explorer_domain.dart';

import 'package:pubdev_explorer/presentation/app_states/settings_notifier.dart';
import 'package:pubdev_explorer/presentation/pages/bookmarks/states/bookmarks_fetcher.dart';
import 'package:pubdev_explorer/presentation/pages/bookmarks/states/bookmarks_notifier.dart';
import 'package:pubdev_explorer/presentation/pages/home/states/bookmark_toggler.dart';
import 'package:pubdev_explorer/presentation/pages/home/states/home_notifier.dart';
import 'package:pubdev_explorer/presentation/pages/home/states/package_fetcher.dart';
import 'package:pubdev_explorer/presentation/pages/home/states/package_names_fetcher.dart';

export 'package:pubdev_explorer_domain/pubdev_explorer_domain.dart';

export 'package:pubdev_explorer/presentation/app_states/settings_notifier.dart';
export 'package:pubdev_explorer/presentation/pages/bookmarks/states/bookmarks_fetcher.dart';
export 'package:pubdev_explorer/presentation/pages/bookmarks/states/bookmarks_notifier.dart';
export 'package:pubdev_explorer/presentation/pages/home/states/bookmark_toggler.dart';
export 'package:pubdev_explorer/presentation/pages/home/states/home_notifier.dart';
export 'package:pubdev_explorer/presentation/pages/home/states/package_fetcher.dart';
export 'package:pubdev_explorer/presentation/pages/home/states/package_names_fetcher.dart';

final settingsRepositoryPot = Pot(
  SettingsRepository.new,
);

final packagesRepositoryPot = Pot(
  PackagesRepository.new,
);

final bookmarksRepositoryPot = Pot(
  BookmarksRepository.new,
);

final settingsNotifierPot = Pot(
  SettingsNotifier.new,
  disposer: (notifier) => notifier.dispose(),
);

//----------------------------------
// For use in limited places
//----------------------------------

final packageNamesFetcherPot = Pot.pending<PackageNamesFetcher>(
  disposer: (fetcher) => fetcher.dispose(),
);

final packageFetcherPot = Pot.pending<PackageFetcher>(
  disposer: (fetcher) => fetcher.dispose(),
);

final bookmarksFetcherPot = Pot.pending<BookmarksFetcher>(
  disposer: (fetcher) => fetcher.dispose(),
);

final bookmarkTogglerPot = Pot.pending<BookmarkToggler>(
  disposer: (toggler) => toggler.dispose(),
);

final homeNotifierPot = Pot.pending<HomeNotifier>(
  disposer: (notifier) => notifier.dispose(),
);

final bookmarksNotifierPot = Pot.pending<BookmarksNotifier>(
  disposer: (notifier) => notifier.dispose(),
);
