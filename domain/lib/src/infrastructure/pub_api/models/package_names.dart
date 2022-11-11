// ignore_for_file: library_private_types_in_public_api

import 'package:json_annotation/json_annotation.dart';

import 'package:pubdev_explorer_domain/src/common/_common.dart';

part '../../../generated/infrastructure/pub_api/models/package_names.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class PackageNames {
  const PackageNames({this.list = const []});

  factory PackageNames.fromJson(JsonMap json) => _$PackageNamesFromJson(json);

  @JsonKey(name: 'packages')
  final List<_Name> list;
}

@JsonSerializable()
class _Name {
  const _Name({this.name = ''});

  factory _Name.fromJson(JsonMap json) => _$NameFromJson(json);

  @JsonKey(name: 'package')
  final String name;

  JsonMap toJson() => _$NameToJson(this);
}
