import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:async_phase_notifier/async_phase_notifier.dart';
import 'package:grab/grab.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/bookmarks/bookmarks_page.dart';
import 'package:pubdev_explorer/presentation/pages/home/widgets/arrow_button.dart';
import 'package:pubdev_explorer/presentation/pages/home/widgets/home_shortcuts.dart';
import 'package:pubdev_explorer/presentation/widgets/_widgets.dart';

HomeNotifier get _notifier => homeNotifierPot();

class HomePage extends StatefulWidget with Grabful {
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final length =
        _notifier.grabAt(context, (s) => s.data!.packageNames.length);
    final hasMore = _notifier.grabAt(context, (s) => s.data!.hasMore);

    return HomeShortcuts(
      pageController: _controller,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('pub.dev explorer'),
          actions: const [
            HelpButton(),
            ThemeModeButton(),
            SizedBox(width: 4.0),
          ],
        ),
        body: SafeArea(
          child: AsyncPhaseListener(
            notifier: _notifier,
            onError: (e, s) {
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentMaterialBanner()
                ..showMaterialBanner(
                  MaterialBanner(
                    content: const Text(
                      'Could not fetch the details.\n'
                      'It may be because the package was published only '
                      'a while ago and its analysis is still ongoing.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: messenger.hideCurrentMaterialBanner,
                        child: Text(
                          'OK',
                          style: context.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
            },
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (index) {
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                      _notifier.onIndexChanged(index);
                    },
                    itemCount: hasMore ? length + 1 : length,
                    itemBuilder: (_, index) =>
                        index == length ? const _PendingItem() : _Item(index),
                  ),
                ),
                SizedBox(
                  width: kContentMaxWidth,
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ArrowButton(
                            pageController: _controller,
                            direction: PageDirection.prev,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'View bookmarks',
                        icon: Icon(
                          Icons.bookmarks,
                          color: context.tertiaryColor,
                        ),
                        iconSize: 32.0,
                        onPressed: () => Navigator.of(context).push(
                          BookmarksPage.route(),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ArrowButton(
                            pageController: _controller,
                            direction: PageDirection.next,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget with Grab {
  const _Item(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    final packageName =
        _notifier.grabAt(context, (s) => s.data!.packageNameAt(index));

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Center(
        child: PackageCard(
          packageName: packageName,
        ),
      ),
    );
  }
}

class _PendingItem extends StatelessWidget with Grab {
  const _PendingItem();

  @override
  Widget build(BuildContext context) {
    final listPhase = _notifier.grab(context);

    return listPhase.when(
      waiting: (_) => const Center(
        child: CupertinoActivityIndicator(),
      ),
      error: (_, __, ___) => Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            _notifier.fetchNames();
          },
          child: const Text('Retry'),
        ),
      ),
      complete: (_) => const SizedBox(),
    );
  }
}
