import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  const CustomScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

bool get isMacOs => defaultTargetPlatform == TargetPlatform.macOS;

extension FormattedDateTime on DateTime? {
  String get formatted =>
      this == null ? '' : DateFormat.yMMMd('en_US').format(this!);

  String get formattedWithTime =>
      this == null ? '' : DateFormat('K:mm a, MMM d, y').format(this!);
}
