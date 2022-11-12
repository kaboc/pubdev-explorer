import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/bookmarks/bookmarks_page.dart';
import 'package:pubdev_explorer/presentation/pages/guide/guide_page.dart';

HomeNotifier get _notifier => homeNotifierPot();

class HomeShortcuts extends StatelessWidget {
  const HomeShortcuts({
    required this.pageController,
    required this.child,
  });

  final PageController pageController;
  final Widget child;

  Package? get _package => _notifier.value.currentPackage;

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
        LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyR):
            const _RefreshIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.f5):
            const _RestartIntent(),
        LogicalKeySet(
          LogicalKeyboardKey.shift,
          LogicalKeyboardKey.meta,
          LogicalKeyboardKey.keyR,
        ): const _RestartIntent(),
        LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.arrowRight):
            const _GoToBookmarksIntent(),
        const SingleActivator(LogicalKeyboardKey.f1): const _OpenGuideIntent(),
        LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.question):
            const _OpenGuideIntent(),
      },
      child: Actions(
        actions: {
          ScrollIntent: _SlideAction(pageController),
          _BookmarkToggleIntent: CallbackAction<_BookmarkToggleIntent>(
            onInvoke: (_) {
              final package = _package;
              if (package != null) {
                _notifier.toggleBookmark(package: package);
              }
              return;
            },
          ),
          _RefreshIntent: CallbackAction<_RefreshIntent>(
            onInvoke: (_) {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              _notifier.fetchPackage(currentPackage: _package, fromWeb: true);
              return;
            },
          ),
          _RestartIntent: CallbackAction<_RestartIntent>(
            onInvoke: (_) => _notifier.restart(),
          ),
          _GoToBookmarksIntent: CallbackAction<_GoToBookmarksIntent>(
            onInvoke: (_) => Navigator.of(context).push(BookmarksPage.route()),
          ),
          _OpenGuideIntent: CallbackAction<_OpenGuideIntent>(
            onInvoke: (_) => Navigator.of(context).push(GuidePage.route()),
          ),
        },
        child: FocusScope(
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

class _OpenGuideIntent extends Intent {
  const _OpenGuideIntent();
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
