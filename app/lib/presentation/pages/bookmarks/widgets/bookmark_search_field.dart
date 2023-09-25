import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:pubdev_explorer/presentation/common/_common.dart';

class BookmarkSearchField extends StatelessWidget with Grab {
  const BookmarkSearchField({
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_types_on_closure_parameters
    final isFocused = focusNode.grabAt(context, (FocusNode n) => n.hasFocus);
    final hasKeywords = controller.grabAt(context, (c) => c.text.isNotEmpty);

    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );

    return TextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: isDesktop,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: context.theme.cardColor,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
        hintText: 'Search',
        enabledBorder: border.copyWith(
          borderSide: BorderSide(color: context.tertiaryColor),
        ),
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: context.secondaryColor),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: isFocused ? context.secondaryColor : null,
        ),
        suffixIcon: Material(
          color: Colors.transparent,
          child: hasKeywords
              ? IconButton(
                  tooltip: 'Clear',
                  icon: Icon(
                    Icons.close,
                    color: context.tertiaryColor,
                  ),
                  splashRadius: 18.0,
                  onPressed: controller.clear,
                )
              : null,
        ),
      ),
    );
  }
}
