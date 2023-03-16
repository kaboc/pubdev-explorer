import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:grab/grab.dart';
import 'package:pottery/pottery.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/platforms/io.dart'
    if (dart.library.html) 'package:pubdev_explorer/platforms/web.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb || kUseMock) {
    useMock();
  }
  openLocalDatabase(executor: openConnection());

  // SettingNotifier is prepared here so that the user-selected
  // theme mode is applied before the first frame.
  settingsNotifierPot.create();

  runApp(const App());
}

class App extends StatelessWidget with Grab {
  const App();

  @override
  Widget build(BuildContext context) {
    final themeMode =
        context.grabAt(settingsNotifierPot(), (Settings s) => s.themeMode);

    return MaterialApp(
      title: 'pub.dev Explorer',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      scrollBehavior: const CustomScrollBehavior(),
      home: Pottery(
        pots: {
          packageNamesFetcherPot: PackageNamesFetcher.new,
          packageFetcherPot: PackageFetcher.new,
          bookmarkTogglerPot: BookmarkToggler.new,
          homeNotifierPot: HomeNotifier.new,
        },
        builder: (_) => const HomePage(),
      ),
    );
  }
}
