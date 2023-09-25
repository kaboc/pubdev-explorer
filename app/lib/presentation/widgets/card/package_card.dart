import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/home/home_page.dart';
import 'package:pubdev_explorer/presentation/widgets/card/highlighted_text.dart';
import 'package:pubdev_explorer/presentation/widgets/card/metrics.dart';
import 'package:pubdev_explorer/presentation/widgets/card/refresh_button.dart';
import 'package:pubdev_explorer/presentation/widgets/card/tag_list.dart';
import 'package:pubdev_explorer/presentation/widgets/card/version_table.dart';
import 'package:pubdev_explorer/presentation/widgets/foundation/linked_text.dart';

PackageCaches get _packageCaches => packageCachesPot();

class PackageCard extends StatelessWidget with Grab {
  const PackageCard({
    required this.packageName,
    this.searchWords = const [],
  });

  final String packageName;
  final List<String> searchWords;

  PackageNotifier? get _notifier => _packageCaches[packageName];

  @override
  Widget build(BuildContext context) {
    final packagePhase = _notifier?.grab(context);
    final package = packagePhase?.data;

    if (packagePhase == null || package == null) {
      return const SizedBox.shrink();
    }

    final isWaiting = packagePhase.isWaiting;
    final isPublisherSearch = homeNotifierPot.of(context).isPublisherSearch;

    final publisher = package.publisher;
    final packageUrl = '$kPubUrl/packages/$packageName';
    final publisherUrl = '$kPubUrl/publishers/$publisher';

    return SizedBox(
      width: kContentMaxWidth - 32.0,
      child: Opacity(
        opacity: isWaiting ? 0.5 : 1.0,
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
                              packageName,
                              keywords: searchWords,
                              style: context.headlineMedium.copyWith(
                                color: Colors.transparent,
                              ),
                            ),
                            LinkedText.external(
                              packageName,
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
                      onPressed:
                          isWaiting ? null : () => _notifier?.toggleBookmark(),
                    ),
                  ],
                ),
                if (package.isEmpty) ...[
                  const SizedBox(height: 60.0),
                  SizedBox(
                    height: 24.0,
                    child:
                        isWaiting ? const CupertinoActivityIndicator() : null,
                  ),
                  const SizedBox(height: 40.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: RefreshButton(
                      onPressed: () => _refresh(context),
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
                                publisher,
                                keywords: searchWords,
                                style: const TextStyle(
                                  color: Colors.transparent,
                                ),
                              ),
                              if (isMockUsed)
                                LinkedText.external(
                                  publisher,
                                  url: publisherUrl,
                                  style: TextStyle(
                                    color: context.secondaryColor,
                                  ),
                                )
                              else
                                LinkedText(
                                  publisher,
                                  style: TextStyle(
                                    color: context.secondaryColor,
                                  ),
                                  onTap: isPublisherSearch
                                      ? null
                                      : () => Navigator.of(context).push(
                                            HomePage.route(
                                              keywords: 'publisher:$publisher',
                                            ),
                                          ),
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
                        onPressed: isWaiting ? null : () => _refresh(context),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _refresh(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    _notifier?.fetchPackage(useCache: false);
  }
}
