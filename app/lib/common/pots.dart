import 'package:pottery/pottery.dart';

import 'package:pubdev_explorer_core/pubdev_explorer_core.dart';

import 'package:pubdev_explorer/presentation/app_states/settings_notifier.dart';
import 'package:pubdev_explorer/presentation/pages/bookmarks/states/bookmarks_notifier.dart';
import 'package:pubdev_explorer/presentation/pages/home/states/home_notifier.dart';
import 'package:pubdev_explorer/presentation/pages/home/states/packages_notifier.dart';

export 'package:pubdev_explorer_core/pubdev_explorer_core.dart';

export 'package:pubdev_explorer/presentation/app_states/settings_notifier.dart';
export 'package:pubdev_explorer/presentation/pages/bookmarks/states/bookmarks_notifier.dart';
export 'package:pubdev_explorer/presentation/pages/home/states/home_notifier.dart';
export 'package:pubdev_explorer/presentation/pages/home/states/packages_notifier.dart';

final settingsRepositoryPot = Pot(
  () => const SettingsRepository(),
);

final packagesRepositoryPot = Pot(
  () => const PackagesRepository(),
);

final bookmarksRepositoryPot = Pot(
  () => const BookmarksRepository(),
);

final settingsNotifierPot = Pot(
  SettingsNotifier.new,
  disposer: (notifier) => notifier.dispose(),
);

//----------------------------------
// For use in limited places
//----------------------------------

final packagesNotifierPot = Pot.pending<PackagesNotifier>(
  disposer: (notifier) => notifier.dispose(),
);

final homeNotifierPot = Pot.pending<HomeNotifier>(
  disposer: (notifier) => notifier.dispose(),
);

final bookmarksNotifierPot = Pot.pending<BookmarksNotifier>(
  disposer: (notifier) => notifier.dispose(),
);
