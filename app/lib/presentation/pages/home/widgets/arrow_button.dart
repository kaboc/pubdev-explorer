import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/bookmarks/bookmarks_page.dart';

enum PageDirection { prev, next }

class Navigation extends StatelessWidget {
  const Navigation({required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kContentMaxWidth,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: _ArrowButton(
                pageController: pageController,
                direction: PageDirection.prev,
              ),
            ),
          ),
          IconButton(
            tooltip: 'View bookmarks',
            icon: Icon(
              Icons.bookmarks,
              color: context.tertiaryColor,
            ),
            iconSize: 32.0,
            onPressed: () => Navigator.of(context).push(
              BookmarksPage.route(),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: _ArrowButton(
                pageController: pageController,
                direction: PageDirection.next,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget with Grab {
  const _ArrowButton({
    required this.pageController,
    required this.direction,
  });

  final PageController pageController;
  final PageDirection direction;

  @override
  Widget build(BuildContext context) {
    final notifier = homeNotifierPot.of(context);

    final toPrev = direction == PageDirection.prev;
    final visible = toPrev
        ? notifier.grabAt(context, (s) => !s.data!.isFirst)
        : notifier.grabAt(context, (s) => !s.data!.isLast);
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
          tooltip: toPrev ? 'Prev' : 'Next',
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
