import 'package:flutter/material.dart';

import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/widgets/card/highlighted_text.dart';
import 'package:pubdev_explorer/presentation/widgets/foundation/linked_text.dart';

class PackageName extends StatelessWidget {
  const PackageName({required this.name, required this.highlights});

  final String name;
  final List<String> highlights;

  @override
  Widget build(BuildContext context) {
    final packageUrl = '$kPubUrl/packages/$name';

    return Stack(
      children: [
        HighlightedText(
          name,
          words: highlights,
          style: context.headlineMedium.copyWith(color: Colors.transparent),
        ),
        LinkedText.external(
          name,
          url: packageUrl,
          style: context.headlineMedium.copyWith(color: context.secondaryColor),
        ),
      ],
    );
  }
}
