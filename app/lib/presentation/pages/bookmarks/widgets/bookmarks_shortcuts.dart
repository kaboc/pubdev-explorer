import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:pubdev_explorer/presentation/pages/guide/guide_page.dart';

class BookmarksShortcuts extends StatelessWidget {
  const BookmarksShortcuts({
    required this.searchController,
    required this.searchFocusNode,
    required this.child,
  });

  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Shortcuts(
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyF):
              RequestFocusIntent(searchFocusNode),
          const SingleActivator(LogicalKeyboardKey.escape):
              const _SearchClearIntent(),
          // Settings for the arrow up/down keys are necessary to
          // prevent the default behaviour of those keys moving
          // the focus up and down, which is unwanted in this app.
          const SingleActivator(LogicalKeyboardKey.arrowUp):
              const ScrollIntent(direction: AxisDirection.up),
          const SingleActivator(LogicalKeyboardKey.arrowDown):
              const ScrollIntent(direction: AxisDirection.down),
          LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.arrowLeft):
              const _BackToHomeIntent(),
          const SingleActivator(LogicalKeyboardKey.f1):
              const _OpenShortcutGuideIntent(),
        },
        child: Actions(
          actions: {
            RequestFocusIntent: _SearchFocusAction(searchController),
            _SearchClearIntent: CallbackAction<_SearchClearIntent>(
              onInvoke: (_) => searchController.clear(),
            ),
            _OpenShortcutGuideIntent: CallbackAction<_OpenShortcutGuideIntent>(
              onInvoke: (_) => Navigator.of(context).push(GuidePage.route()),
            ),
            _BackToHomeIntent: CallbackAction<_BackToHomeIntent>(
              onInvoke: (_) => Navigator.of(context).pop(),
            ),
          },
          child: FocusScope(
            child: child,
          ),
        ),
      ),
    );
  }
}

class _SearchClearIntent extends Intent {
  const _SearchClearIntent();
}

class _OpenShortcutGuideIntent extends Intent {
  const _OpenShortcutGuideIntent();
}

class _BackToHomeIntent extends Intent {
  const _BackToHomeIntent();
}

class _SearchFocusAction extends Action<RequestFocusIntent> {
  _SearchFocusAction(this.searchController);

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
