import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:pubdev_explorer/presentation/pages/guide/guide_page.dart';
import 'package:pubdev_explorer/presentation/pages/home/widgets/home_shortcuts.dart';

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
    return Shortcuts(
      shortcuts: {
        const SingleActivator(LogicalKeyboardKey.keyF, control: true):
            RequestFocusIntent(searchFocusNode),
        const SingleActivator(LogicalKeyboardKey.keyF, meta: true):
            RequestFocusIntent(searchFocusNode),
        const SingleActivator(LogicalKeyboardKey.escape):
            const SearchClearIntent(),
        // Settings for the arrow up/down keys are necessary to
        // prevent the default behaviour of those keys moving
        // the focus up and down, which is unwanted in this app.
        const SingleActivator(LogicalKeyboardKey.arrowUp):
            const ScrollIntent(direction: AxisDirection.up),
        const SingleActivator(LogicalKeyboardKey.arrowDown):
            const ScrollIntent(direction: AxisDirection.down),
        const SingleActivator(LogicalKeyboardKey.arrowLeft, alt: true):
            const BackToHomeIntent(),
        const SingleActivator(LogicalKeyboardKey.f1): const OpenGuideIntent(),
        const SingleActivator(LogicalKeyboardKey.question, shift: true):
            const OpenGuideIntent(),
      },
      child: Actions(
        actions: {
          RequestFocusIntent: SearchFocusAction(searchController),
          SearchClearIntent: CallbackAction<SearchClearIntent>(
            onInvoke: (_) => searchController.clear(),
          ),
          OpenGuideIntent: CallbackAction<OpenGuideIntent>(
            onInvoke: (_) => Navigator.of(context).push(GuidePage.route()),
          ),
          BackToHomeIntent: CallbackAction<BackToHomeIntent>(
            onInvoke: (_) => Navigator.of(context).pop(),
          ),
        },
        child: FocusScope(
          child: child,
        ),
      ),
    );
  }
}
