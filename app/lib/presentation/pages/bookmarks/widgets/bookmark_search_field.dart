import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:pubdev_explorer/presentation/common/_common.dart';

class BookmarkSearchField extends StatelessWidget {
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
    final hasInput = controller.grabAt(context, (c) => c.text.isNotEmpty);

    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.emailAddress,
      onTapOutside: (_) => focusNode.unfocus(),
      decoration: InputDecoration(
        hintText: 'Search',
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        prefixIconConstraints: BoxConstraints.tight(const Size(48.0, 40.0)),
        suffixIconConstraints: BoxConstraints.tight(const Size(48.0, 40.0)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.tertiaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.secondaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: isFocused ? context.secondaryColor : null,
        ),
        suffixIcon: Material(
          color: Colors.transparent,
          child: hasInput
              ? IconButton(
                  tooltip: 'Clear',
                  splashRadius: 18.0,
                  onPressed: controller.clear,
                  icon: Icon(
                    Icons.close,
                    color: context.tertiaryColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
