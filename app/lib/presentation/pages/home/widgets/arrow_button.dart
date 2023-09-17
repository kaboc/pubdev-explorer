import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';

enum PageDirection { prev, next }

HomeNotifier get _notifier => homeNotifierPot();

class ArrowButton extends StatelessWidget with Grab {
  const ArrowButton({
    required this.pageController,
    required this.direction,
  });

  final PageController pageController;
  final PageDirection direction;

  @override
  Widget build(BuildContext context) {
    final toPrev = direction == PageDirection.prev;

    final visible = toPrev
        ? _notifier.grabAt(context, (s) => !s.data!.isFirst)
        : _notifier.grabAt(context, (s) => !s.data!.isLast);

    final toAdjacentPage =
        toPrev ? pageController.previousPage : pageController.nextPage;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: Visibility(
        visible: visible,
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        child: IconButton(
          tooltip: toPrev ? 'Prev (newer)' : 'Next (older)',
          icon: Icon(
            toPrev ? Icons.arrow_left : Icons.arrow_right,
            color: context.tertiaryColor,
          ),
          iconSize: 48.0,
          splashRadius: 32.0,
          onPressed: () => toAdjacentPage(
            duration: kSlideDuration,
            curve: kSlideCurve,
          ),
        ),
      ),
    );
  }
}
