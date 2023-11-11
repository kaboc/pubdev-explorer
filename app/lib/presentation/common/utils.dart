import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  const CustomScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => PointerDeviceKind.values.toSet();
}

bool get isMacOs => defaultTargetPlatform == TargetPlatform.macOS;

extension FormattedDateTime on DateTime? {
  String get formatted {
    final self = this;
    return self == null ? '' : DateFormat.yMMMd('en_US').format(self);
  }

  String get formattedWithTime {
    final self = this;
    return self == null ? '' : DateFormat('K:mm a, MMM d, y').format(self);
  }
}
