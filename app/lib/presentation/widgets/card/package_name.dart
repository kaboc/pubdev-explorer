import 'package:flutter/material.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/widgets/foundation/highlighted_text.dart';

class PackageName extends StatelessWidget {
  const PackageName({required this.name, required this.highlights});

  final String name;
  final Iterable<String> highlights;

  @override
  Widget build(BuildContext context) {
    final packageUrl = '${kPubUrl}packages/$name';

    return HighlightedText.externalLink(
      name,
      words: highlights,
      url: packageUrl,
      style: context.headlineMedium,
    );
  }
}
