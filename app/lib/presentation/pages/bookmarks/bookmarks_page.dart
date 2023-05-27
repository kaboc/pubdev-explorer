import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:grab/grab.dart';
import 'package:pottery/pottery.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/bookmarks/widgets/bookmarks_shortcuts.dart';
import 'package:pubdev_explorer/presentation/widgets/_widgets.dart';

BookmarksFetcher get _fetcher => bookmarksFetcherPot();

BookmarksNotifier get _notifier => bookmarksNotifierPot();

class BookmarksPage extends StatefulWidget with Grabful {
  const BookmarksPage._();

  static Route<void> route() {
    return FadingPageRoute<void>(
      builder: (_) => Pottery(
        pots: {
          bookmarksFetcherPot: BookmarksFetcher.new,
          bookmarksNotifierPot: BookmarksNotifier.new,
        },
        builder: (_) => const BookmarksPage._(),
      ),
    );
  }

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      _notifier.onSearchWordsChanged(_searchController.text);
    });

    _notifier.onFirstFetchComplete = () {
      final scrollController = PrimaryScrollController.of(context);
      if (scrollController.hasClients) {
        scrollController.jumpTo(0.0);
      }
    };
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookmarksPhase = _fetcher.grab(context);
    final packagePhases = _notifier.grabAt(context, (s) => s.packagePhases);
    final hasSearchWords =
        _searchController.grabAt(context, (v) => v.text.isNotEmpty);

    return BookmarksShortcuts(
      searchController: _searchController,
      searchFocusNode: _searchFocusNode,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bookmarks'),
          actions: const [
            HelpButton(),
            ThemeModeButton(),
            SizedBox(width: 4.0),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                autofocus: isDesktop,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: context.theme.cardColor,
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
                  hintText: 'Search',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: context.secondaryColor),
                  ),
                  suffixIcon: Material(
                    color: Colors.transparent,
                    child: hasSearchWords
                        ? IconButton(
                            tooltip: 'Clear',
                            icon: Icon(
                              Icons.close,
                              color: context.tertiaryColor,
                            ),
                            splashRadius: 18.0,
                            onPressed: _searchController.clear,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 1.0),
              Expanded(
                child: bookmarksPhase.when(
                  waiting: (_) => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  error: (_, __, ___) => packagePhases.isEmpty
                      ? Center(
                          child: ElevatedButton(
                            onPressed: _notifier.fetchNextBookmarks,
                            child: const Text('Retry'),
                          ),
                        )
                      : _ListView(
                          controller: PrimaryScrollController.of(context),
                          packagePhases: packagePhases,
                        ),
                  complete: (_) => packagePhases.isEmpty
                      ? Center(
                          child: Text(
                            hasSearchWords
                                ? 'No matching package was found.'
                                : 'No packages have been bookmarked yet.',
                            style: TextStyle(color: context.tertiaryColor),
                          ),
                        )
                      : _ListView(
                          controller: PrimaryScrollController.of(context),
                          packagePhases: packagePhases,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListView extends StatelessWidget with Grab {
  const _ListView({required this.controller, required this.packagePhases});

  final ScrollController controller;
  final List<AsyncPhase<Package>> packagePhases;

  @override
  Widget build(BuildContext context) {
    final searchWords = _notifier.grabAt(context, (s) => s.searchWords);

    return BottomDetector(
      extent: 200.0,
      onEnterBottom: _notifier.fetchNextBookmarks,
      builder: (context, _) {
        return ListView.separated(
          controller: controller,
          padding: const EdgeInsets.all(16.0),
          itemCount: packagePhases.length,
          itemBuilder: (_, index) {
            final package = packagePhases.at(index);

            return package == null
                ? const SizedBox.shrink()
                : Center(
                    child: SizedBox(
                      width: kContentMaxWidth - 32.0,
                      child: PackageCard(
                        packagePhase: package,
                        searchWords: searchWords,
                        onBookmarkPressed: (package) {
                          _notifier.toggleBookmark(package: package);
                        },
                        onRefreshPressed: (package) {
                          _notifier.fetchPackage(package: package);
                        },
                      ),
                    ),
                  );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(height: 16.0);
          },
        );
      },
    );
  }
}
