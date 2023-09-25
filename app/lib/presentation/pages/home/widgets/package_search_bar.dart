import 'package:flutter/material.dart';

import 'package:grab/grab.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/home/home_page.dart';

class PackageSearchBar extends StatefulWidget with Grabful {
  const PackageSearchBar({
    required this.controller,
    required this.focusNode,
    this.initialValue,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String? initialValue;

  @override
  State<PackageSearchBar> createState() => _PackageSearchBarState();
}

class _PackageSearchBarState extends State<PackageSearchBar> {
  @override
  void initState() {
    super.initState();

    final initialValue = widget.initialValue;
    if (initialValue != null) {
      widget.controller.text = initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFocused =
        // ignore: avoid_types_on_closure_parameters
        widget.focusNode.grabAt(context, (FocusNode n) => n.hasFocus);
    final hasKeywords =
        widget.controller.grabAt(context, (c) => c.text.isNotEmpty);

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.emailAddress,
      onFieldSubmitted: (_) => _search(context),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: context.theme.cardColor,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
        hintText: 'Search packages',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: context.secondaryColor),
        ),
        prefixIcon: Material(
          color: Colors.transparent,
          child: IconButton(
            tooltip: 'Search',
            icon: Icon(
              Icons.search,
              color: isFocused ? context.secondaryColor : null,
            ),
            splashRadius: 18.0,
            onPressed: () => _search(context),
          ),
        ),
        suffixIcon: Material(
          color: Colors.transparent,
          child: hasKeywords
              ? IconButton(
                  tooltip: 'Clear',
                  icon: Icon(Icons.close, color: context.tertiaryColor),
                  splashRadius: 18.0,
                  onPressed: widget.controller.clear,
                )
              : null,
        ),
      ),
    );
  }

  void _search(BuildContext context) {
    final notifier = homeNotifierPot.of(context);
    final trimmed = widget.controller.text.trim();

    if (notifier.isSearch) {
      notifier.fetchNames(keywords: trimmed);
    } else if (trimmed.isEmpty) {
      notifier.restart();
    } else {
      Navigator.of(context).push(
        HomePage.route(keywords: trimmed),
      );
      widget.controller.clear();
    }
  }
}
