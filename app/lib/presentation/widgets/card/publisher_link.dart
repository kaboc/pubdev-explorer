import 'package:flutter/material.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/home/home_page.dart';
import 'package:pubdev_explorer/presentation/widgets/foundation/highlighted_text.dart';

class PublisherLink extends StatelessWidget {
  const PublisherLink({required this.package, required this.highlights});

  final Package package;
  final Iterable<String> highlights;

  @override
  Widget build(BuildContext context) {
    final isPublisherSearch = homeNotifierPot.of(context).isPublisherSearch;

    final publisher = package.publisher;
    final publisherUrl = '${kPubUrl}publishers/$publisher';

    return Row(
      children: [
        Icon(
          Icons.verified_outlined,
          size: context.bodyMedium.fontSize,
          color: context.tertiaryColor,
        ),
        const SizedBox(width: 4.0),
        Flexible(
          child: isMockUsed
              ? HighlightedText.externalLink(
                  publisher,
                  words: highlights,
                  url: publisherUrl,
                )
              : HighlightedText.link(
                  publisher,
                  words: highlights,
                  onTap: isPublisherSearch
                      ? null
                      : () => Navigator.of(context).push(
                            HomePage.route(
                              keywords: ['publisher:$publisher'],
                            ),
                          ),
                ),
        ),
      ],
    );
  }
}
