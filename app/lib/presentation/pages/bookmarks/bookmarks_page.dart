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
              if (packagePhases.isEmpty) ...[
                if (bookmarksPhase.isInitial || bookmarksPhase.isWaiting)
                  const Expanded(
                    child: CupertinoActivityIndicator(),
                  )
                else if (bookmarksPhase.isError)
                  Expanded(
                    child: Center(
                      child: ElevatedButton(
                        onPressed: _notifier.fetchBookmarks,
                        child: const Text('Retry'),
                      ),
                    ),
                  )
                else if (bookmarksPhase.isComplete)
                  Expanded(
                    child: Center(
                      child: Text(
                        hasSearchWords
                            ? 'No matching package was found.'
                            : 'No packages have been bookmarked yet.',
                        style: TextStyle(color: context.tertiaryColor),
                      ),
                    ),
                  ),
              ] else
                Expanded(
                  child: _ListView(
                    packagePhases: packagePhases,
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
  const _ListView({required this.packagePhases});

  final List<AsyncPhase<Package>> packagePhases;

  @override
  Widget build(BuildContext context) {
    final searchWords = _notifier.grabAt(context, (s) => s.searchWords);
    final hasMore = _notifier.grabAt(context, (s) => s.hasMore);
    final isFetchError = _fetcher.grabAt(context, (s) => s.isError);

    return BottomScrollDetector(
      // Use search words as key to jump back to top
      // when the list is refreshed with new words.
      key: ValueKey(searchWords),
      extent: 200.0,
      padding: const EdgeInsets.all(16.0),
      onBottomReached:
          hasMore && !isFetchError ? _notifier.fetchNextBookmarks : null,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: packagePhases.length,
            (_, index) {
              final package = packagePhases.at(index);

              return package == null
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        if (index > 0) const SizedBox(height: 16.0),
                        Center(
                          child: PackageCard(
                            packagePhase: package,
                            searchWords: searchWords,
                            onBookmarkPressed: (package) {
                              _notifier.toggleBookmark(
                                package: package,
                              );
                            },
                            onRefreshPressed: (package) {
                              _notifier.fetchPackage(package: package);
                            },
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
        if (isFetchError)
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _notifier.fetchNextBookmarks,
                child: const Text('Retry'),
              ),
            ),
          ),
      ],
    );
  }
}
