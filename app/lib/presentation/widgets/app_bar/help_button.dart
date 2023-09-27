import 'package:flutter/material.dart';

import 'package:pubdev_explorer/presentation/pages/guide/guide_page.dart';

class HelpButton extends StatelessWidget {
  const HelpButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Shortcut keys',
      icon: const Icon(Icons.help),
      splashRadius: 28.0,
      onPressed: () => Navigator.of(context).push(GuidePage.route()),
    );
  }
}
