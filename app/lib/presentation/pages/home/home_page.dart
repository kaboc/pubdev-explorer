import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:async_phase_notifier/async_phase_notifier.dart';
import 'package:grab/grab.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/bookmarks/bookmarks_page.dart';
import 'package:pubdev_explorer/presentation/pages/home/widgets/arrow_button.dart';
import 'package:pubdev_explorer/presentation/pages/home/widgets/home_shortcuts.dart';
import 'package:pubdev_explorer/presentation/pages/home/widgets/package_search_bar.dart';
import 'package:pubdev_explorer/presentation/widgets/_widgets.dart';

class HomePage extends StatefulWidget with Grabful {
  const HomePage();

  static Route<void> route({required String keywords}) {
    return FadingPageRoute<void>(
      builder: (_) => ScopedPottery(
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

    return GestureDetector(
      onTap: _searchFocusNode.unfocus,
      child: HomeShortcuts(
        pageController: _pageController,
        child: Scaffold(
          appBar: AppBar(
            title: keywords == null
                ? const Text('pub.dev explorer')
                : notifier.isPublisherSearch
                    ? const Text('Publisher')
                    : Text('Search - $keywords'),
            actions: const [
              HelpButton(),
              ThemeModeButton(),
              SizedBox(width: 4.0),
            ],
          ),
          body: SafeArea(
            child: AsyncPhaseListener(
              notifier: notifier,
              onError: (e, __) {
                final messenger = ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner();

                if (e is! UnimplementedError) {
                  messenger.showMaterialBanner(
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
                }
              },
              child: Column(
                children: [
                  Shortcuts.manager(
                    manager: ShortcutManager(
                      modal: true,
                      shortcuts: {
                        const SingleActivator(LogicalKeyboardKey.escape):
                            const SearchClearIntent(),
                      },
                    ),
                    child: DefaultTextEditingShortcuts(
                      child: PackageSearchBar(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        initialValue: keywords,
                        enabled: !notifier.isPublisherSearch,
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        ScaffoldMessenger.of(context)
                            .hideCurrentMaterialBanner();
                        notifier.onIndexChanged(index);
                      },
                      itemCount: hasMore ? length + 1 : length,
                      itemBuilder: (_, index) => index == length
                          ? const _PendingItem()
                          : _Item(index, _searchController),
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
                              pageController: _pageController,
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
                              pageController: _pageController,
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
      ),
    );
  }
}

class _Item extends StatelessWidget with Grab {
  const _Item(this.index, this.searchController);

  final int index;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final notifier = homeNotifierPot.of(context);
    final packageName =
        notifier.grabAt(context, (s) => s.data!.packageNameAt(index));

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
