import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:pubdev_explorer/common/_common.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  const CustomScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

bool get isDesktop =>
    defaultTargetPlatform != TargetPlatform.android &&
    defaultTargetPlatform != TargetPlatform.iOS;

bool get isMacOs => defaultTargetPlatform == TargetPlatform.macOS;

extension FormattedDateTime on DateTime? {
  String get formatted =>
      this == null ? '' : DateFormat.yMMMd('en_US').format(this!);

  String get formattedWithTime =>
      this == null ? '' : DateFormat('K:mm a, MMM d, y').format(this!);
}

extension ReplacePackageInList on List<AsyncPhase<Package>> {
  AsyncPhase<Package>? at(int index) {
    return index < length ? this[index] : null;
  }

  List<AsyncPhase<Package>> copyAndReplace({
    required AsyncPhase<Package> packagePhase,
  }) {
    final index = indexWhere((v) => v.data!.name == packagePhase.data!.name);
    return index < 0
        ? List.of(this)
        : (List.of(this)..replaceRange(index, index + 1, [packagePhase]));
  }
}
