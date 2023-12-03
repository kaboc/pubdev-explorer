import 'package:flutter/material.dart';

import 'package:custom_text/custom_text.dart' show PatternMatcher, TextParser;

import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/widgets/foundation/linked_text.dart';

class HighlightedText extends StatefulWidget {
  const HighlightedText(
    this.text, {
    required this.words,
    this.style,
  })  : linkText = null,
        onTap = null,
        url = null,
        external = false;

  const HighlightedText.link(
    this.text, {
    required this.words,
    required String this.linkText,
    required this.onTap,
    this.style,
  })  : url = null,
        external = false;

  const HighlightedText.externalLink(
    this.text, {
    required this.words,
    required String this.linkText,
    required String this.url,
    this.style,
  })  : onTap = null,
        external = true;

  final String text;
  final List<String> words;
  final TextStyle? style;
  final String? linkText;
  final VoidCallback? onTap;
  final String? url;
  final bool external;

  @override
  State<HighlightedText> createState() => _HighlightedTextState();
}

class _HighlightedTextState extends State<HighlightedText> {
  late List<InlineSpan> _spans = [TextSpan(text: widget.text)];

  @override
  void initState() {
    super.initState();
    _buildSpansWithHighlight();
  }

  Future<void> _buildSpansWithHighlight() async {
    if (widget.words.isEmpty) {
      return;
    }

    final parser = TextParser(
      matchers: [PatternMatcher(widget.words.join('|'))],
      caseSensitive: false,
    );
    final elements = await parser.parse(
      widget.text,
      useIsolate: false,
    );

    setState(() {
      _spans = [
        for (final element in elements)
          TextSpan(
            text: element.text,
            style: element.matcherType == PatternMatcher
                ? TextStyle(
                    color: widget.linkText == null
                        ? AppTheme.light.textTheme.bodyMedium?.color
                        : null,
                    backgroundColor: Colors.yellow.shade200,
                  )
                : null,
          ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final linkText = widget.linkText;

    return linkText == null
        ? Text.rich(
            TextSpan(children: _spans),
            style: widget.style,
          )
        : widget.external
            ? LinkedText.external(
                linkText,
                spans: _spans,
                url: widget.url!,
                style: widget.style,
              )
            : LinkedText(
                linkText,
                spans: _spans,
                onTap: widget.onTap,
                style: widget.style,
              );
  }
}
