import 'package:flutter/widgets.dart';

class FadingPageRoute<T> extends PageRouteBuilder<T> {
  FadingPageRoute({required WidgetBuilder builder})
      : super(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          pageBuilder: (context, _, __) => builder(context),
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
