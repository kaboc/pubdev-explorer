import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/guide/widgets/guide_shortcuts.dart';
import 'package:pubdev_explorer/presentation/pages/guide/widgets/guide_table.dart';
import 'package:pubdev_explorer/presentation/widgets/_widgets.dart';

class GuidePage extends StatelessWidget {
  const GuidePage._();

  static Route<void> route() {
    return PageRouteBuilder<void>(
      fullscreenDialog: true,
      opaque: false,
      pageBuilder: (_, __, ___) => const GuidePage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GuideShortcuts(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Guide'),
          actions: const [
            ThemeModeButton(),
            SizedBox(width: 4.0),
          ],
        ),
        backgroundColor: context.primaryColor.withOpacity(0.6),
        body: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: SizedBox(
            // This height is necessary for GestureDetector to
            // cover the whole page below the app bar.
            height: double.infinity,
            child: SingleChildScrollView(
              primary: true,
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  width: isMacOs && !kIsWeb ? 540.0 : 500.0,
                  // This GestureDetector prevents the card from being
                  // affected by the GestureDetector up in the tree.
                  child: GestureDetector(
                    onTap: () {},
                    child: const Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 32.0),
                        child: _Body(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const GuideHeading('Shortcuts'),
        const SizedBox(height: 12.0),
        const GuideSubHeading('Explorer page'),
        const SizedBox(height: 8.0),
        GuideTable({
          'Left': 'Slides to the previous package',
          'Right': 'Slides to the next package',
          'B': 'Bookmarks the package',
          if (kIsWeb) ...{
            'R': 'Fetches the latest package info',
            'Shift + R': 'Fetches the latest package list',
          } else if (isMacOs) ...{
            'Command + R': 'Fetches the latest package info',
            'Shift + Command + R': 'Fetches the latest package list',
          } else ...{
            'F5': 'Fetches the latest package info',
            'Ctrl + F5': 'Fetches the latest package list',
          },
          isMacOs ? 'Command + F' : 'Ctrl + F': 'Focuses the search bar',
          'Esc': 'Clears the search words',
          'Alt + Right': 'Opens the Bookmarks page',
          isMacOs ? 'Shift + ?' : 'F1': 'Opens this guide',
        }),
        const SizedBox(height: 32.0),
        const GuideSubHeading('Search page'),
        const SizedBox(height: 8.0),
        const GuideTable({
          'Alt + Left': 'Goes back to the explorer page',
        }),
        const SizedBox(height: 32.0),
        const GuideSubHeading('Bookmarks page'),
        const SizedBox(height: 8.0),
        GuideTable({
          'Up': 'Scrolls up',
          'Down': 'Scrolls down',
          isMacOs ? 'Fn + Up' : 'Page Up': 'Scrolls up a page',
          isMacOs ? 'Fn + Down' : 'Page Down': 'Scrolls down a page',
          isMacOs ? 'Command + F' : 'Ctrl + F': 'Focuses the search box',
          'Esc': 'Clears the search words',
          'Alt + Left': 'Goes back to the explorer page',
          isMacOs ? 'Shift + ?' : 'F1': 'Opens this guide',
        }),
        const SizedBox(height: 32.0),
        const GuideSubHeading('Guide page'),
        const SizedBox(height: 8.0),
        const GuideTable({
          'Esc': "Closes the guide you're reading",
        }),
        const SizedBox(height: 32.0),
        const GuideHeading('About this app'),
        const SizedBox(height: 12.0),
        const HighlightedText.externalLink(
          'GitHub',
          url: 'https://github.com/kaboc/pubdev-explorer',
        ),
        const SizedBox(height: 8.0),
        HighlightedText.link(
          'Licenses',
          linkText: 'Licenses',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => const LicensePage(
                applicationName: kAppName,
                applicationLegalese: 'kaboc',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
