import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/platforms/io.dart'
    if (dart.library.html) 'package:pubdev_explorer/platforms/web.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureApi(isWeb: kIsWeb);
  openLocalDatabase(executor: openConnection());

  // SettingNotifier is prepared here so that the user-selected
  // theme mode is applied before the first frame.
  await settingsNotifierPot().ensureReady();

  runApp(
    const Grab(child: App()),
  );
}

class App extends StatelessWidget {
  const App();

  @override
  Widget build(BuildContext context) {
    final themeMode = settingsNotifierPot().grabAt(context, (s) => s.themeMode);

    return MaterialApp(
      title: kAppName,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      scrollBehavior: const CustomScrollBehavior(),
      home: Pottery(
        pots: {
          packageCachesPot: () => <String, PackageNotifier>{},
          homeNotifierPot: HomeNotifier.new,
        },
        builder: (_) => const HomePage(),
      ),
    );
  }
}
