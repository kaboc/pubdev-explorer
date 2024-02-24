// ignore_for_file: library_private_types_in_public_api

import 'package:pubdev_explorer_core/src/common/_common.dart';

extension type const PackageBasics._(JsonMap json) {
  const PackageBasics.fromJson(this.json);

  String get name => switch (json) {
        {'name': final String name} => name,
        _ => '',
      };

  _Version get latest => _Version(
        switch (json) {
          {'latest': final JsonMap latest} => latest,
          _ => {},
        },
      );

  List<_Version> get versions => [
        if (json case {'versions': final List<Object?> versions})
          for (final version in versions)
            if (version is JsonMap) _Version(version),
      ];
}

extension type const _Version(JsonMap json) {
  String get version => switch (json) {
        {'version': final String version} => version,
        _ => '',
      };

  _PubSpec get pubSpec => _PubSpec(
        switch (json) {
          {'pubspec': final JsonMap pubSpec} => pubSpec,
          _ => {},
        },
      );

  DateTime? get published => switch (json) {
        {'published': final String published} => published.toLocalTime(),
        _ => null,
      };
}

extension type const _PubSpec(JsonMap json) {
  String get description => switch (json) {
        {'description': final String description} => description,
        _ => '',
      };
}
