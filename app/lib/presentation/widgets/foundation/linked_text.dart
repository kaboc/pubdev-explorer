import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:custom_text/custom_text.dart';
import 'package:url_launcher/link.dart';

import 'package:pubdev_explorer/presentation/common/_common.dart';

class LinkedText extends StatelessWidget {
  const LinkedText(
    this.text, {
    this.spans,
    required this.onTap,
    this.style,
  }) : url = null;

  const LinkedText.external(
    this.text, {
    this.spans,
    required String this.url,
    this.style,
  }) : onTap = null;

  final String text;
  final List<InlineSpan>? spans;
  final TextStyle? style;
  final VoidCallback? onTap;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return url == null
        ? _Text(text, spans, style, onTap)
        : Link(
            uri: Uri.tryParse(url!),
            target: kIsWeb ? LinkTarget.blank : LinkTarget.self,
            builder: (_, followLink) {
              return _Text(text, spans, style, followLink);
            },
          );
  }
}

class _Text extends StatefulWidget {
  const _Text(this.text, this.spans, this.style, this.onTap);

  final String text;
  final List<InlineSpan>? spans;
  final TextStyle? style;
  final VoidCallback? onTap;

  @override
  State<_Text> createState() => _TextState();
}

class _TextState extends State<_Text> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final tappable = widget.onTap != null;
    final style = (widget.style ?? DefaultTextStyle.of(context).style)
        .copyWith(color: context.secondaryColor);

    return Actions(
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) => widget.onTap?.call(),
        ),
      },
      child: Focus(
        onFocusChange: (focused) {
          setState(() => _focused = focused);
        },
        child: CustomText.spans(
          spans: widget.spans ?? [TextSpan(text: widget.text)],
          definitions: [
            TextDefinition(matcher: PatternMatcher(widget.text)),
          ],
          style: style,
          matchStyle: TextStyle(
            decoration: _focused ? TextDecoration.underline : null,
          ),
          hoverStyle: TextStyle(color: style.color?.withOpacity(0.7)),
          onTap: tappable ? (_) => widget.onTap?.call() : null,
        ),
      ),
    );
  }
}
