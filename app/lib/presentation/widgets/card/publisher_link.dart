import 'package:flutter/material.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/home/home_page.dart';
import 'package:pubdev_explorer/presentation/widgets/card/highlighted_text.dart';
import 'package:pubdev_explorer/presentation/widgets/foundation/linked_text.dart';

class PublisherLink extends StatelessWidget {
  const PublisherLink({required this.package, required this.highlights});

  final Package package;
  final List<String> highlights;

  @override
  Widget build(BuildContext context) {
    final isPublisherSearch = homeNotifierPot.of(context).isPublisherSearch;

    final publisher = package.publisher;
    final publisherUrl = '$kPubUrl/publishers/$publisher';

    return Row(
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
                words: highlights,
                style: const TextStyle(color: Colors.transparent),
              ),
              if (isMockUsed)
                LinkedText.external(
                  publisher,
                  url: publisherUrl,
                  style: TextStyle(color: context.secondaryColor),
                )
              else
                LinkedText(
                  publisher,
                  style: TextStyle(color: context.secondaryColor),
                  onTap: isPublisherSearch
                      ? null
                      : () => Navigator.of(context).push(
                            HomePage.route(
                              keywords: ['publisher:$publisher'],
                            ),
                          ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
