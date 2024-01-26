import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:grab/grab.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';
import 'package:pubdev_explorer/presentation/pages/home/home_page.dart';
import 'package:pubdev_explorer/presentation/pages/home/widgets/home_shortcuts.dart';

class PackageSearchBar extends StatefulWidget {
  const PackageSearchBar({
    required this.controller,
    required this.focusNode,
    this.initialValue,
    this.enabled = true,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String? initialValue;
  final bool enabled;

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
    final hasInput =
        widget.controller.grabAt(context, (c) => c.text.isNotEmpty);

    return Shortcuts.manager(
      manager: ShortcutManager(
        modal: true,
        shortcuts: {
          const SingleActivator(LogicalKeyboardKey.escape):
              const SearchClearIntent(),
          const SingleActivator(LogicalKeyboardKey.tab):
              const NextFocusIntent(),
        },
      ),
      child: DefaultTextEditingShortcuts(
        child: TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          keyboardType: TextInputType.emailAddress,
          onTapOutside: (_) => widget.focusNode.unfocus(),
          onFieldSubmitted: (_) => _search(context),
          decoration: InputDecoration(
            hintText: 'Search packages',
            contentPadding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.tertiaryColor),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.secondaryColor),
              borderRadius: BorderRadius.zero,
            ),
            prefixIcon: Material(
              color: Colors.transparent,
              child: IconButton(
                tooltip: 'Search',
                splashRadius: 18.0,
                onPressed: () => _search(context),
                icon: Icon(
                  Icons.search,
                  color: isFocused ? context.secondaryColor : null,
                ),
              ),
            ),
            suffixIcon: Material(
              color: Colors.transparent,
              child: widget.enabled && hasInput
                  ? IconButton(
                      tooltip: 'Clear',
                      splashRadius: 18.0,
                      onPressed: widget.controller.clear,
                      icon: Icon(Icons.close, color: context.tertiaryColor),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  void _search(BuildContext context) {
    final notifier = homeNotifierPot.of(context);

    final keywords = [
      for (final word in widget.controller.text.split(' '))
        if (word.trim().isNotEmpty) word.trim(),
    ];

    if (notifier.isSearch) {
      notifier.fetchNames(keywords: keywords);
      widget.controller.text = keywords.join(' ');
    } else if (keywords.isEmpty) {
      notifier.restart();
    } else {
      Navigator.of(context).push(
        HomePage.route(keywords: keywords),
      );
      widget.controller.clear();
    }
  }
}
