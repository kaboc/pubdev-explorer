import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/bookmarks/bookmarks_page.dart';
import 'package:pubdev_explorer/presentation/pages/guide/guide_page.dart';

HomeNotifier get _notifier => homeNotifierPot();
PackagesNotifier get _packagesNotifier => packagesNotifierPot();

class HomeShortcuts extends StatelessWidget {
  const HomeShortcuts({
    required this.pageController,
    required this.child,
  });

  final PageController pageController;
  final Widget child;

  String get _packageName => _notifier.value.data!.currentPackageName;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.arrowLeft):
            ScrollIntent(direction: AxisDirection.left),
        SingleActivator(LogicalKeyboardKey.arrowRight):
            ScrollIntent(direction: AxisDirection.right),
        SingleActivator(LogicalKeyboardKey.keyB): _BookmarkToggleIntent(),
        SingleActivator(LogicalKeyboardKey.f5): _RefreshIntent(),
        SingleActivator(LogicalKeyboardKey.keyR, meta: true): _RefreshIntent(),
        SingleActivator(LogicalKeyboardKey.keyR): _RefreshIntent(),
        SingleActivator(LogicalKeyboardKey.f5, control: true): _RestartIntent(),
        SingleActivator(LogicalKeyboardKey.keyR, shift: true, meta: true):
            _RestartIntent(),
        SingleActivator(LogicalKeyboardKey.keyR, shift: true): _RestartIntent(),
        SingleActivator(LogicalKeyboardKey.arrowRight, alt: true):
            _GoToBookmarksIntent(),
        SingleActivator(LogicalKeyboardKey.f1): _OpenGuideIntent(),
        SingleActivator(LogicalKeyboardKey.question, shift: true):
            _OpenGuideIntent(),
      },
      child: Actions(
        actions: {
          ScrollIntent: _SlideAction(pageController),
          _BookmarkToggleIntent: CallbackAction<_BookmarkToggleIntent>(
            onInvoke: (_) {
              final package = _packagesNotifier.value[_packageName]?.data;
              _packagesNotifier.toggleBookmark(package: package);
              return;
            },
          ),
          _RefreshIntent: CallbackAction<_RefreshIntent>(
            onInvoke: (_) {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              _packagesNotifier.fetchPackage(
                name: _packageName,
                useCache: false,
              );
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
