// ignore_for_file: library_private_types_in_public_api

import 'package:pubdev_explorer_core/src/common/_common.dart';

extension type const PackageNames._(JsonMap json) {
  const PackageNames.fromJson(this.json);

  List<_Name> get list => [
        if (json case {'packages': final List<Object?> packages})
          for (final data in packages)
            if (data is JsonMap) _Name(data),
      ];
}

extension type const _Name(JsonMap json) {
  String get name => switch (json) {
        {'package': final String name} => name,
        _ => '',
      };
}
