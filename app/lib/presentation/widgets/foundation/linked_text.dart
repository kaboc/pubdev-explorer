import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:custom_text/custom_text.dart';
import 'package:url_launcher/link.dart';

class LinkedText extends StatelessWidget {
  const LinkedText(
    this.text, {
    required this.onTap,
    this.style,
  }) : url = null;

  const LinkedText.external(
    this.text, {
    required String this.url,
    this.style,
  }) : onTap = null;

  final String text;
  final TextStyle? style;
  final VoidCallback? onTap;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return url == null
        ? _Text(text, style, onTap)
        : Link(
            uri: Uri.tryParse(url!),
            target: kIsWeb ? LinkTarget.blank : LinkTarget.self,
            builder: (_, followLink) {
              return _Text(text, style, followLink);
            },
          );
  }
}

class _Text extends StatefulWidget {
  const _Text(this.text, this.style, this.onTap);

  final String text;
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

    final matchStyle =
        tappable ? widget.style ?? DefaultTextStyle.of(context).style : null;
    final hoverStyle =
        matchStyle?.copyWith(color: matchStyle.color?.withOpacity(0.7));

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
        child: CustomText(
          widget.text,
          definitions: const [
            TextDefinition(matcher: PatternMatcher('.+')),
          ],
          matchStyle: matchStyle?.copyWith(
            decoration: _focused ? TextDecoration.underline : null,
          ),
          hoverStyle: hoverStyle,
          onTap: tappable ? (_) => widget.onTap?.call() : null,
        ),
      ),
    );
  }
}
