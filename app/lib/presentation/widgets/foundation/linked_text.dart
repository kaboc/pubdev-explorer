import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:custom_text/custom_text.dart';
import 'package:url_launcher/link.dart';

class LinkedText extends StatefulWidget {
  const LinkedText(
    this.text, {
    required this.url,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final String url;

  @override
  State<LinkedText> createState() => _LinkedTextState();
}

class _LinkedTextState extends State<LinkedText> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final matchStyle = widget.style ?? DefaultTextStyle.of(context).style;
    final hoverStyle = matchStyle.copyWith(
      color: matchStyle.color?.withOpacity(0.7),
    );

    return Link(
      uri: Uri.tryParse(widget.url),
      target: kIsWeb ? LinkTarget.blank : LinkTarget.self,
      builder: (_, followLink) {
        return Actions(
          actions: {
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (_) => followLink?.call(),
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
              matchStyle: matchStyle.copyWith(
                decoration: _focused ? TextDecoration.underline : null,
              ),
              hoverStyle: hoverStyle,
              onTap: (_, __) => followLink!.call(),
            ),
          ),
        );
      },
    );
  }
}
