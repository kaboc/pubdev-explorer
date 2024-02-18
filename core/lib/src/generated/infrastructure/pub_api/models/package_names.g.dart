// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, strict_raw_type, duplicate_ignore

part of '../../../../infrastructure/pub_api/models/package_names.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageNames _$PackageNamesFromJson(Map<String, dynamic> json) => PackageNames(
      list: (json['packages'] as List<dynamic>?)
              ?.map((e) => _Name.fromJson(e as Map<String, dynamic>)) ??
          const [],
    );

_Name _$NameFromJson(Map<String, dynamic> json) => _Name(
      name: json['package'] as String? ?? '',
    );

Map<String, dynamic> _$NameToJson(_Name instance) => <String, dynamic>{
      'package': instance.name,
    };
