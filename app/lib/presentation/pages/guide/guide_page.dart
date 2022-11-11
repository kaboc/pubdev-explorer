import 'package:flutter/material.dart';

import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/guide/widgets/guide_shortcuts.dart';
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
                  width: 500.0,
                  // This GestureDetector prevents the card from being
                  // affected by the GestureDetector up in the tree.
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      elevation: 8.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
                        child: Column(
                          children: [
                            const _Heading('Explore page shortcuts'),
                            const SizedBox(height: 10.0),
                            const _Table({
                              '←': 'Slides to the previous package',
                              '→': 'Slides to the next package',
                              'b': 'Bookmarks the package',
                              'F5': 'Fetches the latest package info',
                              'Ctrl + F5': 'Fetches the latest package list',
                              'Alt + →': 'Opens the Bookmarks page',
                              'F1': 'Opens this guide',
                            }),
                            const SizedBox(height: 32.0),
                            const _Heading('Bookmarks page shortcuts'),
                            const SizedBox(height: 10.0),
                            const _Table({
                              '↑': 'Scrolls up',
                              '↓': 'Scrolls down',
                              'Page Up': 'Scrolls up a page',
                              'Page Down': 'Scrolls down a page',
                              'Ctrl + f':
                                  'Focuses the search box and selects all',
                              'Esc': 'Clears the search words',
                              'Alt + ←': 'Goes back to the Explore page',
                              'F1': 'Opens this guide',
                            }),
                            const SizedBox(height: 32.0),
                            const _Heading("This guide's shortcuts"),
                            const SizedBox(height: 10.0),
                            const _Table({
                              'Esc': "Closes the guide you're reading",
                            }),
                            const SizedBox(height: 32.0),
                            const _Heading('GitHub'),
                            const SizedBox(height: 10.0),
                            LinkedText(
                              'https://github.com/kaboc/pubdev-explorer',
                              url: 'https://github.com/kaboc/pubdev-explorer',
                              style: TextStyle(color: context.secondaryColor),
                            ),
                          ],
                        ),
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

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.headlineSmall.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _Table extends StatelessWidget {
  const _Table(this.content);

  final Map<String, String> content;

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(0.32),
        1: IntrinsicColumnWidth(),
        2: FlexColumnWidth(0.68),
      },
      children: [
        for (final key in content.keys)
          TableRow(
            children: [
              TableCell(
                child: Text(
                  key,
                  textAlign: TextAlign.right,
                  style: context.theme.textTheme.bodyLarge,
                ),
              ),
              const TableCell(
                child: SizedBox(width: 28.0),
              ),
              TableCell(
                child: Text(content[key]!),
              ),
            ],
          ),
      ],
    );
  }
}
