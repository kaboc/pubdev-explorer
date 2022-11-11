import 'package:flutter/material.dart';

import 'package:pubdev_explorer/presentation/common/_common.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Refresh',
      icon: Icon(
        Icons.refresh,
        size: 20.0,
        color: context.tertiaryColor,
      ),
      onPressed: onPressed,
    );
  }
}
