import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:custom_text/custom_text.dart';
import 'package:url_launcher/link.dart';

import 'package:pubdev_explorer/presentation/common/_common.dart';

class HighlightedText extends StatefulWidget {
  const HighlightedText(
    this.text, {
    required this.words,
    this.style,
  })  : linkText = null,
        onTap = null,
        url = null;

  const HighlightedText.link(
    this.text, {
    required this.words,
    required String this.linkText,
    required this.onTap,
    this.style,
  }) : url = null;

  const HighlightedText.externalLink(
    this.text, {
    required this.words,
    required String this.linkText,
    required String this.url,
    this.style,
  }) : onTap = null;

  final String text;
  final List<String> words;
  final TextStyle? style;
  final String? linkText;
  final VoidCallback? onTap;
  final String? url;

  @override
  State<HighlightedText> createState() => _HighlightedTextState();
}

class _HighlightedTextState extends State<HighlightedText> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final linkText = widget.linkText;
    final linkStyle = TextStyle(
      color: context.secondaryColor,
      decorationColor: context.secondaryColor,
      decoration: _focused ? TextDecoration.underline : null,
    );

    final child = CustomText(
      widget.text,
      style: widget.style,
      definitions: [
        if (linkText == null)
          const TextDefinition(
            matcher: PatternMatcher(''),
          )
        else
          TextDefinition(
            matcher: ExactMatcher([linkText]),
            matchStyle: linkStyle,
            hoverStyle: linkStyle.copyWith(
              color: context.secondaryColor.withOpacity(0.7),
              decorationColor: context.secondaryColor.withOpacity(0.7),
            ),
            mouseCursor: SystemMouseCursors.click,
          ),
      ],
      preBuilder: CustomSpanBuilder(
        parserOptions: const ParserOptions(caseSensitive: false),
        definitions: [
          TextDefinition(
            matcher: ExactMatcher(widget.words),
            matchStyle: TextStyle(backgroundColor: Colors.yellow.shade200),
          ),
        ],
      ),
    );

    if (widget.onTap == null && widget.url == null) {
      return child;
    }

    final onTap = widget.onTap;

    return onTap == null
        ? Link(
            uri: Uri.tryParse(widget.url!),
            target: kIsWeb ? LinkTarget.blank : LinkTarget.self,
            builder: (_, followLink) {
              return _Actions(
                onTap: followLink!,
                onFocusChange: _onFocusChange,
                child: child,
              );
            },
          )
        : _Actions(
            onTap: onTap,
            onFocusChange: _onFocusChange,
            child: child,
          );
  }

  void _onFocusChange(bool focused) {
    setState(() => _focused = focused);
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.onTap,
    required this.onFocusChange,
    required this.child,
  });

  final VoidCallback onTap;
  final ValueChanged<bool> onFocusChange;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Actions(
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) => onTap(),
          ),
        },
        child: Focus(
          onFocusChange: onFocusChange,
          child: child,
        ),
      ),
    );
  }
}
