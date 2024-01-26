import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:async_phase_notifier/async_phase_notifier.dart';
import 'package:grab/grab.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/home/widgets/arrow_button.dart';
import 'package:pubdev_explorer/presentation/pages/home/widgets/home_shortcuts.dart';
import 'package:pubdev_explorer/presentation/pages/home/widgets/package_search_bar.dart';
import 'package:pubdev_explorer/presentation/widgets/_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  static Route<void> route({required List<String> keywords}) {
    return FadingPageRoute<void>(
      builder: (_) => LocalPottery(
        pots: {
          homeNotifierPot: () => HomeNotifier(keywords: keywords),
        },
        disposer: (pots) {
          final notifier = pots[homeNotifierPot] as HomeNotifier?;
          notifier?.dispose.call();
        },
        builder: (_) => const HomePage(),
      ),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  ScaffoldMessengerState get _messenger => ScaffoldMessenger.of(context);

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Uses `of()` instead of directly using the pot to obtain
    // the notifier from the nearest scoped pot if existing.
    final notifier = homeNotifierPot.of(context);

    final length = notifier.grabAt(context, (s) => s.data!.packageNames.length);
    final hasMore = notifier.grabAt(context, (s) => s.data!.hasMore);
    final keywords = notifier.grabAt(context, (s) => s.data!.keywords);
    final joinedKeywords = keywords?.join(' ');

    return HomeShortcuts(
      pageController: _pageController,
      searchController: _searchController,
      searchFocusNode: _searchFocusNode,
      child: Scaffold(
        appBar: AppBar(
          title: notifier.isSearch
              ? notifier.isPublisherSearch
                  ? const Text('Publisher')
                  : Text('Search - $joinedKeywords')
              : const Text('pub.dev explorer'),
          actions: const [
            HelpButton(),
            ThemeModeButton(),
            SizedBox(width: 4.0),
          ],
        ),
        body: SafeArea(
          child: AsyncPhaseListener(
            notifier: notifier,
            onError: (e, _) {
              // Shows a message in the center of the screen instead of
              // a material banner if the error is UnimplementedError.
              if (e is! UnimplementedError) {
                _showErrorBanner();
              }
            },
            child: Column(
              children: [
                PackageSearchBar(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  initialValue: joinedKeywords,
                  enabled: !notifier.isPublisherSearch,
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: hasMore ? length + 1 : length,
                    itemBuilder: (_, index) {
                      return index == length
                          ? const _PendingItem()
                          : _Item(index, _searchController);
                    },
                    onPageChanged: (index) {
                      _messenger.hideCurrentMaterialBanner();
                      notifier.onIndexChanged(index);
                    },
                  ),
                ),
                Navigation(
                  pageController: _pageController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorBanner() {
    _messenger
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
              onPressed: _messenger.hideCurrentMaterialBanner,
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
  }
}

class _Item extends StatelessWidget {
  const _Item(this.index, this.searchController);

  final int index;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final notifier = homeNotifierPot.of(context);
    final packageName =
        notifier.grabAt(context, (s) => s.data!.packageNameAt(index));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: PackageCard(name: packageName),
      ),
    );
  }
}

class _PendingItem extends StatelessWidget {
  const _PendingItem();

  @override
  Widget build(BuildContext context) {
    final notifier = homeNotifierPot.of(context);
    final listPhase = notifier.grab(context);

    return listPhase.when(
      waiting: (_) => const Center(
        child: CupertinoActivityIndicator(),
      ),
      error: (_, e, __) => Center(
        child: e is UnimplementedError
            ? const Text(
                'Search is not supported in this environment.',
              )
            : ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  notifier.fetchNames();
                },
                child: const Text('Retry'),
              ),
      ),
      complete: (_) => const SizedBox(),
    );
  }
}
