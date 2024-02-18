import 'package:flutter/widgets.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';

class TagList extends StatelessWidget {
  const TagList({required this.tags});

  final Iterable<Tag> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 3.0,
      runSpacing: 3.0,
      children: [
        for (final tag in tags)
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              color: context.tertiaryColor,
            ),
            padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
            child: Text(
              tag.label,
              style: context.bodySmall.copyWith(
                color: context.theme.colorScheme.background,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
