import 'package:pottery/pottery.dart';

import 'package:pubdev_explorer_core/pubdev_explorer_core.dart';

import 'package:pubdev_explorer/presentation/app_states/settings_notifier.dart';
import 'package:pubdev_explorer/presentation/pages/home/states/home_notifier.dart';
import 'package:pubdev_explorer/presentation/pages/home/states/package_notifier.dart';

export 'package:pottery/pottery.dart';
export 'package:pubdev_explorer_core/pubdev_explorer_core.dart';

export 'package:pubdev_explorer/presentation/app_states/settings_notifier.dart';
export 'package:pubdev_explorer/presentation/pages/home/states/home_notifier.dart';
export 'package:pubdev_explorer/presentation/pages/home/states/package_notifier.dart';

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

final packageCachesPot = Pot.pending<PackageCaches>(
  disposer: (caches) => caches
    ..forEach((_, notifier) => notifier.dispose())
    ..clear(),
);

final homeNotifierPot = Pot.pending<HomeNotifier>(
  disposer: (notifier) => notifier.dispose(),
);
