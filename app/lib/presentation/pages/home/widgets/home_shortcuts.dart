import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/bookmarks/bookmarks_page.dart';
import 'package:pubdev_explorer/presentation/pages/guide/guide_page.dart';

PackageCaches get _packageCaches => packageCachesPot();

class HomeShortcuts extends StatelessWidget {
  const HomeShortcuts({
    required this.pageController,
    required this.searchController,
    required this.searchFocusNode,
    required this.child,
  });

  final PageController pageController;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final Widget child;

  PackageNotifier? _currentPackageNotifier(BuildContext context) {
    final notifier = homeNotifierPot.of(context);
    return _packageCaches[notifier.value.data!.currentPackageName];
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        const SingleActivator(LogicalKeyboardKey.arrowLeft):
            const ScrollIntent(direction: AxisDirection.left),
        const SingleActivator(LogicalKeyboardKey.arrowRight):
            const ScrollIntent(direction: AxisDirection.right),
        const SingleActivator(LogicalKeyboardKey.keyB):
            const _BookmarkToggleIntent(),
        const SingleActivator(LogicalKeyboardKey.f5): const _RefreshIntent(),
        const SingleActivator(LogicalKeyboardKey.keyR, meta: true):
            const _RefreshIntent(),
        const SingleActivator(LogicalKeyboardKey.keyR): const _RefreshIntent(),
        const SingleActivator(LogicalKeyboardKey.f5, control: true):
            const _RestartIntent(),
        const SingleActivator(LogicalKeyboardKey.keyR, shift: true, meta: true):
            const _RestartIntent(),
        const SingleActivator(LogicalKeyboardKey.keyR, shift: true):
            const _RestartIntent(),
        const SingleActivator(LogicalKeyboardKey.arrowRight, alt: true):
            const _GoToBookmarksIntent(),
        const SingleActivator(LogicalKeyboardKey.keyF, control: true):
            RequestFocusIntent(searchFocusNode),
        const SingleActivator(LogicalKeyboardKey.keyF, meta: true):
            RequestFocusIntent(searchFocusNode),
        const SingleActivator(LogicalKeyboardKey.arrowLeft, alt: true):
            const BackToHomeIntent(),
        const SingleActivator(LogicalKeyboardKey.f1): const OpenGuideIntent(),
        const SingleActivator(LogicalKeyboardKey.question, shift: true):
            const OpenGuideIntent(),
      },
      child: Actions(
        actions: {
          ScrollIntent: _SlideAction(pageController),
          _BookmarkToggleIntent: CallbackAction<_BookmarkToggleIntent>(
            onInvoke: (_) {
              _currentPackageNotifier(context)?.toggleBookmark();
              return;
            },
          ),
          _RefreshIntent: CallbackAction<_RefreshIntent>(
            onInvoke: (_) {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              _currentPackageNotifier(context)?.fetchPackage(useCache: false);
              return;
            },
          ),
          _RestartIntent: CallbackAction<_RestartIntent>(
            onInvoke: (_) => homeNotifierPot.of(context).restart(),
          ),
          _GoToBookmarksIntent: CallbackAction<_GoToBookmarksIntent>(
            onInvoke: (_) => Navigator.of(context).push(BookmarksPage.route()),
          ),
          RequestFocusIntent: SearchFocusAction(searchController),
          SearchClearIntent: CallbackAction<SearchClearIntent>(
            onInvoke: (_) => searchController.clear(),
          ),
          BackToHomeIntent: CallbackAction<BackToHomeIntent>(
            onInvoke: (_) {
              final navigator = Navigator.of(context);
              if (navigator.canPop()) {
                navigator.pop();
              }
              return;
            },
          ),
          OpenGuideIntent: CallbackAction<OpenGuideIntent>(
            onInvoke: (_) => Navigator.of(context).push(GuidePage.route()),
          ),
        },
        child: FocusScope(
          autofocus: true,
          child: child,
        ),
      ),
    );
  }
}

class _BookmarkToggleIntent extends Intent {
  const _BookmarkToggleIntent();
}

class _RefreshIntent extends Intent {
  const _RefreshIntent();
}

class _RestartIntent extends Intent {
  const _RestartIntent();
}

class _GoToBookmarksIntent extends Intent {
  const _GoToBookmarksIntent();
}

class _SlideAction extends Action<ScrollIntent> {
  _SlideAction(this.pageController);

  final PageController pageController;

  @override
  void invoke(ScrollIntent intent) {
    if (intent.direction == AxisDirection.left) {
      pageController.previousPage(
        duration: kSlideDuration,
        curve: kSlideCurve,
      );
    } else {
      pageController.nextPage(
        duration: kSlideDuration,
        curve: kSlideCurve,
      );
    }
  }
}

//======================================================
// Intents and actions shared among multiple pages
//======================================================

class SearchClearIntent extends Intent {
  const SearchClearIntent();
}

class BackToHomeIntent extends Intent {
  const BackToHomeIntent();
}

class OpenGuideIntent extends Intent {
  const OpenGuideIntent();
}

class SearchFocusAction extends Action<RequestFocusIntent> {
  SearchFocusAction(this.searchController);

  final TextEditingController searchController;

  @override
  void invoke(RequestFocusIntent intent) {
    intent.focusNode.requestFocus();

    searchController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: searchController.text.length,
    );
  }
}
