// ignore_for_file: library_private_types_in_public_api

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:pubdev_explorer_core/src/common/_common.dart';

part '../../../generated/infrastructure/pub_api/models/package_basics.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class PackageBasics {
  const PackageBasics({
    this.name = '',
    this.latest = const _Version(),
    this.versions = const [],
  });

  factory PackageBasics.fromJson(JsonMap json) => _$PackageBasicsFromJson(json);

  final String name;
  final _Version latest;
  final Iterable<_Version> versions;
}

@JsonSerializable()
class _Version extends Equatable {
  const _Version({
    this.version = '',
    this.pubSpec = const _PubSpec(),
    this.published,
  });

  factory _Version.fromJson(JsonMap json) => _$VersionFromJson(json);

  final String version;

  @JsonKey(name: 'pubspec')
  final _PubSpec pubSpec;

  @JsonKey(fromJson: _dateTimeFromJson)
  final DateTime? published;

  @override
  List<Object> get props => [version];

  JsonMap toJson() => _$VersionToJson(this);

  static DateTime? _dateTimeFromJson(String? text) =>
      text == null ? null : DateTime.tryParse(text)?.toLocal();
}

@JsonSerializable()
class _PubSpec {
  const _PubSpec({this.description = ''});

  factory _PubSpec.fromJson(JsonMap json) => _$PubSpecFromJson(json);

  final String description;

  JsonMap toJson() => _$PubSpecToJson(this);
}
