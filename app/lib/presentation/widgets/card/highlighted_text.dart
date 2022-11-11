import 'package:flutter/material.dart';

import 'package:custom_text/custom_text.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';

class HighlightedText extends StatelessWidget {
  const HighlightedText(
    this.text, {
    required this.keywords,
    this.style,
  });

  final String text;
  final List<String> keywords;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return keywords.isEmpty
        ? Text(text, style: style)
        : CustomText(
            text,
            parserOptions: const ParserOptions(caseSensitive: false),
            definitions: [
              TextDefinition(matcher: PatternMatcher(keywords.join('|'))),
            ],
            style: style,
            matchStyle: TextStyle(
              color: AppTheme.light.textTheme.bodyMedium!.color,
              backgroundColor: Colors.yellow.shade200,
            ),
          );
  }
}
