import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class GuideShortcuts extends StatelessWidget {
  const GuideShortcuts({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.escape): _CloseGuideIntent(),
        SingleActivator(LogicalKeyboardKey.arrowUp):
            ScrollIntent(direction: AxisDirection.up),
        SingleActivator(LogicalKeyboardKey.arrowDown):
            ScrollIntent(direction: AxisDirection.down),
      },
      child: Actions(
        actions: {
          _CloseGuideIntent: CallbackAction<_CloseGuideIntent>(
            onInvoke: (_) => Navigator.of(context).pop(),
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

class _CloseGuideIntent extends Intent {
  const _CloseGuideIntent();
}
