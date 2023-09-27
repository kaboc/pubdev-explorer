import 'package:flutter/material.dart';

import 'package:custom_text/custom_text.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';

class HighlightedText extends StatelessWidget {
  const HighlightedText(
    this.text, {
    required this.words,
    this.style,
  });

  final String text;
  final List<String> words;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return words.isEmpty
        ? Text(text, style: style)
        : CustomText(
            text,
            parserOptions: const ParserOptions(caseSensitive: false),
            definitions: [
              TextDefinition(matcher: PatternMatcher(words.join('|'))),
            ],
            style: style,
            matchStyle: TextStyle(
              color: AppTheme.light.textTheme.bodyMedium!.color,
              backgroundColor: Colors.yellow.shade200,
            ),
          );
  }
}
