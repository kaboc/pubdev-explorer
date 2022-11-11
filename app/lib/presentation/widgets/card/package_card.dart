import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/widgets/_widgets.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    required this.packagePhase,
    required this.onBookmarkPressed,
    required this.onRefreshPressed,
    this.searchWords = const [],
  });

  final AsyncPhase<Package> packagePhase;
  final void Function(Package) onBookmarkPressed;
  final void Function(Package) onRefreshPressed;
  final List<String> searchWords;

  @override
  Widget build(BuildContext context) {
    final package = packagePhase.data!;

    const pubUrl = 'https://pub.dev/';
    final packageUrl = '$pubUrl/packages/${package.name}';
    final publisherUrl = '$pubUrl/publishers/${package.publisher}';

    return Opacity(
      opacity: packagePhase.isWaiting ? 0.5 : 1.0,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Stack(
                        children: [
                          HighlightedText(
                            package.name,
                            keywords: searchWords,
                            style: context.headlineMedium.copyWith(
                              color: Colors.transparent,
                            ),
                          ),
                          LinkedText(
                            package.name,
                            url: packageUrl,
                            style: context.headlineMedium.copyWith(
                              color: context.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    tooltip: 'Bookmark',
                    icon: package.isBookmarked
                        ? const Icon(
                            Icons.bookmark,
                            color: Colors.lightGreen,
                          )
                        : Icon(
                            Icons.bookmark_outline,
                            color: context.tertiaryColor,
                          ),
                    onPressed: packagePhase.isWaiting
                        ? null
                        : () => onBookmarkPressed(package),
                  ),
                ],
              ),
              if (package.isEmpty) ...[
                const SizedBox(height: 60.0),
                SizedBox(
                  height: 24.0,
                  child: packagePhase.isWaiting
                      ? const CupertinoActivityIndicator()
                      : null,
                ),
                const SizedBox(height: 40.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: RefreshButton(
                    onPressed: () => onRefreshPressed(package),
                  ),
                ),
              ] else ...[
                const SizedBox(height: 16.0),
                Metrics(package: package),
                const SizedBox(height: 24.0),
                HighlightedText(
                  package.description,
                  keywords: searchWords,
                  style: const TextStyle(fontSize: 15.0),
                ),
                const SizedBox(height: 24.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    TagList(tags: package.sdks),
                    const SizedBox(height: 3.0),
                    TagList(tags: package.platforms),
                  ],
                ),
                if (package.publisher.isNotEmpty) ...[
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Icon(
                        Icons.verified_outlined,
                        size: context.bodyMedium.fontSize,
                        color: context.tertiaryColor,
                      ),
                      const SizedBox(width: 4.0),
                      Flexible(
                        child: Stack(
                          children: [
                            HighlightedText(
                              package.publisher,
                              keywords: searchWords,
                              style: const TextStyle(
                                color: Colors.transparent,
                              ),
                            ),
                            LinkedText(
                              package.publisher,
                              url: publisherUrl,
                              style: TextStyle(color: context.secondaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: DefaultTextStyle(
                        style: context.bodySmall.copyWith(
                          fontSize: 14.0,
                          color: context.tertiaryColor,
                        ),
                        child: VersionTable(package: package),
                      ),
                    ),
                    RefreshButton(
                      onPressed: packagePhase.isWaiting
                          ? null
                          : () => onRefreshPressed(package),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
