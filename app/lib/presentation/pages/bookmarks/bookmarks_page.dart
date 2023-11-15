import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/bookmarks/widgets/bookmark_search_field.dart';
import 'package:pubdev_explorer/presentation/pages/bookmarks/widgets/bookmarks_shortcuts.dart';
import 'package:pubdev_explorer/presentation/widgets/_widgets.dart';

BookmarksNotifier get _notifier => bookmarksNotifierPot();

class BookmarksPage extends StatefulWidget with Grabful {
  const BookmarksPage._();

  static Route<void> route() {
    return FadingPageRoute<void>(
      builder: (_) => Pottery(
        pots: {
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
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      _notifier.onKeywordsChanged(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookmarksPhase = _notifier.grab(context);
    final names = _notifier.grabAt(context, (s) => s.data!.packageNames);
    final isSearching =
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
              if (names.isNotEmpty || isSearching) ...[
                Container(
                  width: kContentMaxWidth,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
                  child: SizedBox(
                    width: 200.0,
                    child: BookmarkSearchField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                    ),
                  ),
                ),
                const SizedBox(height: 1.0),
              ],
              if (names.isEmpty) ...[
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
                        isSearching
                            ? 'No matching package was found.'
                            : 'No packages have been bookmarked yet.',
                        style: TextStyle(color: context.tertiaryColor),
                      ),
                    ),
                  ),
              ] else
                Expanded(
                  child: _ListView(
                    packageNames: names,
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
  const _ListView({required this.packageNames});

  final Set<String> packageNames;

  @override
  Widget build(BuildContext context) {
    final keywords = _notifier.grabAt(context, (s) => s.data!.keywords);
    final hasMore = _notifier.grabAt(context, (s) => s.data!.hasMore);
    final isFetchError = _notifier.grabAt(context, (s) => s.isError);

    return BottomScrollDetector(
      // Uses search words as key to jump back to top
      // when the list is refreshed with new words.
      key: ValueKey(keywords),
      extent: 200.0,
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      primary: true,
      onBottomReached:
          hasMore && !isFetchError ? _notifier.fetchNextBookmarks : null,
      slivers: [
        SliverList.builder(
          itemCount: packageNames.length,
          itemBuilder: (_, index) {
            return Column(
              children: [
                if (index > 0) const SizedBox(height: 16.0),
                Center(
                  child: PackageCard(
                    name: packageNames.elementAtOrNull(index) ?? '',
                    highlights: keywords,
                  ),
                ),
              ],
            );
          },
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
