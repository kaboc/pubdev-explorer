// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, strict_raw_type, duplicate_ignore

part of '../../../../infrastructure/pub_api/models/package_basics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageBasics _$PackageBasicsFromJson(Map<String, dynamic> json) =>
    PackageBasics(
      name: json['name'] as String? ?? '',
      latest: json['latest'] == null
          ? const _Version()
          : _Version.fromJson(json['latest'] as Map<String, dynamic>),
      versions: (json['versions'] as List<dynamic>?)
              ?.map((e) => _Version.fromJson(e as Map<String, dynamic>)) ??
          const [],
    );

_Version _$VersionFromJson(Map<String, dynamic> json) => _Version(
      version: json['version'] as String? ?? '',
      pubSpec: json['pubspec'] == null
          ? const _PubSpec()
          : _PubSpec.fromJson(json['pubspec'] as Map<String, dynamic>),
      published: _Version._dateTimeFromJson(json['published'] as String?),
    );

Map<String, dynamic> _$VersionToJson(_Version instance) => <String, dynamic>{
      'version': instance.version,
      'pubspec': instance.pubSpec,
      'published': instance.published?.toIso8601String(),
    };

_PubSpec _$PubSpecFromJson(Map<String, dynamic> json) => _PubSpec(
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$PubSpecToJson(_PubSpec instance) => <String, dynamic>{
      'description': instance.description,
    };
