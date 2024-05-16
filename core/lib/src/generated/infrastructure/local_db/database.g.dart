// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: strict_raw_type

part of '../../../infrastructure/local_db/database.dart';

// ignore_for_file: type=lint
class $SettingsTableTable extends SettingsTable
    with TableInfo<$SettingsTableTable, SettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _themeModeIndexMeta =
      const VerificationMeta('themeModeIndex');
  @override
  late final GeneratedColumn<int> themeModeIndex = GeneratedColumn<int>(
      'theme_mode_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [id, themeModeIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_table';
  @override
  VerificationContext validateIntegrity(Insertable<SettingsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme_mode_index')) {
      context.handle(
          _themeModeIndexMeta,
          themeModeIndex.isAcceptableOrUnknown(
              data['theme_mode_index']!, _themeModeIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      themeModeIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}theme_mode_index'])!,
    );
  }

  @override
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }
}

class SettingsTableData extends DataClass
    implements Insertable<SettingsTableData> {
  final int id;
  final int themeModeIndex;
  const SettingsTableData({required this.id, required this.themeModeIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['theme_mode_index'] = Variable<int>(themeModeIndex);
    return map;
  }

  SettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SettingsTableCompanion(
      id: Value(id),
      themeModeIndex: Value(themeModeIndex),
    );
  }

  factory SettingsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsTableData(
      id: serializer.fromJson<int>(json['id']),
      themeModeIndex: serializer.fromJson<int>(json['themeModeIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeModeIndex': serializer.toJson<int>(themeModeIndex),
    };
  }

  SettingsTableData copyWith({int? id, int? themeModeIndex}) =>
      SettingsTableData(
        id: id ?? this.id,
        themeModeIndex: themeModeIndex ?? this.themeModeIndex,
      );
  @override
  String toString() {
    return (StringBuffer('SettingsTableData(')
          ..write('id: $id, ')
          ..write('themeModeIndex: $themeModeIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, themeModeIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsTableData &&
          other.id == this.id &&
          other.themeModeIndex == this.themeModeIndex);
}

class SettingsTableCompanion extends UpdateCompanion<SettingsTableData> {
  final Value<int> id;
  final Value<int> themeModeIndex;
  const SettingsTableCompanion({
    this.id = const Value.absent(),
    this.themeModeIndex = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.themeModeIndex = const Value.absent(),
  });
  static Insertable<SettingsTableData> custom({
    Expression<int>? id,
    Expression<int>? themeModeIndex,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeModeIndex != null) 'theme_mode_index': themeModeIndex,
    });
  }

  SettingsTableCompanion copyWith(
      {Value<int>? id, Value<int>? themeModeIndex}) {
    return SettingsTableCompanion(
      id: id ?? this.id,
      themeModeIndex: themeModeIndex ?? this.themeModeIndex,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeModeIndex.present) {
      map['theme_mode_index'] = Variable<int>(themeModeIndex.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('themeModeIndex: $themeModeIndex')
          ..write(')'))
        .toString();
  }
}

class $PackagesTableTable extends PackagesTable
    with TableInfo<$PackagesTableTable, PackagesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackagesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latestMeta = const VerificationMeta('latest');
  @override
  late final GeneratedColumn<String> latest = GeneratedColumn<String>(
      'latest', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latestAtMeta =
      const VerificationMeta('latestAt');
  @override
  late final GeneratedColumn<DateTime> latestAt = GeneratedColumn<DateTime>(
      'latest_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _preReleaseMeta =
      const VerificationMeta('preRelease');
  @override
  late final GeneratedColumn<String> preRelease = GeneratedColumn<String>(
      'pre_release', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _preReleaseAtMeta =
      const VerificationMeta('preReleaseAt');
  @override
  late final GeneratedColumn<DateTime> preReleaseAt = GeneratedColumn<DateTime>(
      'pre_release_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _sdksMeta = const VerificationMeta('sdks');
  @override
  late final GeneratedColumn<String> sdks = GeneratedColumn<String>(
      'sdks', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _platformsMeta =
      const VerificationMeta('platforms');
  @override
  late final GeneratedColumn<String> platforms = GeneratedColumn<String>(
      'platforms', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _publisherMeta =
      const VerificationMeta('publisher');
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
      'publisher', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
      'points', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _maxPointsMeta =
      const VerificationMeta('maxPoints');
  @override
  late final GeneratedColumn<int> maxPoints = GeneratedColumn<int>(
      'max_points', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _likesMeta = const VerificationMeta('likes');
  @override
  late final GeneratedColumn<int> likes = GeneratedColumn<int>(
      'likes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _popularityMeta =
      const VerificationMeta('popularity');
  @override
  late final GeneratedColumn<double> popularity = GeneratedColumn<double>(
      'popularity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _savedAtMeta =
      const VerificationMeta('savedAt');
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
      'saved_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        name,
        description,
        latest,
        latestAt,
        preRelease,
        preReleaseAt,
        sdks,
        platforms,
        publisher,
        points,
        maxPoints,
        likes,
        popularity,
        savedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'packages_table';
  @override
  VerificationContext validateIntegrity(Insertable<PackagesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('latest')) {
      context.handle(_latestMeta,
          latest.isAcceptableOrUnknown(data['latest']!, _latestMeta));
    } else if (isInserting) {
      context.missing(_latestMeta);
    }
    if (data.containsKey('latest_at')) {
      context.handle(_latestAtMeta,
          latestAt.isAcceptableOrUnknown(data['latest_at']!, _latestAtMeta));
    }
    if (data.containsKey('pre_release')) {
      context.handle(
          _preReleaseMeta,
          preRelease.isAcceptableOrUnknown(
              data['pre_release']!, _preReleaseMeta));
    }
    if (data.containsKey('pre_release_at')) {
      context.handle(
          _preReleaseAtMeta,
          preReleaseAt.isAcceptableOrUnknown(
              data['pre_release_at']!, _preReleaseAtMeta));
    }
    if (data.containsKey('sdks')) {
      context.handle(
          _sdksMeta, sdks.isAcceptableOrUnknown(data['sdks']!, _sdksMeta));
    } else if (isInserting) {
      context.missing(_sdksMeta);
    }
    if (data.containsKey('platforms')) {
      context.handle(_platformsMeta,
          platforms.isAcceptableOrUnknown(data['platforms']!, _platformsMeta));
    } else if (isInserting) {
      context.missing(_platformsMeta);
    }
    if (data.containsKey('publisher')) {
      context.handle(_publisherMeta,
          publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta));
    } else if (isInserting) {
      context.missing(_publisherMeta);
    }
    if (data.containsKey('points')) {
      context.handle(_pointsMeta,
          points.isAcceptableOrUnknown(data['points']!, _pointsMeta));
    } else if (isInserting) {
      context.missing(_pointsMeta);
    }
    if (data.containsKey('max_points')) {
      context.handle(_maxPointsMeta,
          maxPoints.isAcceptableOrUnknown(data['max_points']!, _maxPointsMeta));
    } else if (isInserting) {
      context.missing(_maxPointsMeta);
    }
    if (data.containsKey('likes')) {
      context.handle(
          _likesMeta, likes.isAcceptableOrUnknown(data['likes']!, _likesMeta));
    } else if (isInserting) {
      context.missing(_likesMeta);
    }
    if (data.containsKey('popularity')) {
      context.handle(
          _popularityMeta,
          popularity.isAcceptableOrUnknown(
              data['popularity']!, _popularityMeta));
    } else if (isInserting) {
      context.missing(_popularityMeta);
    }
    if (data.containsKey('saved_at')) {
      context.handle(_savedAtMeta,
          savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta));
    } else if (isInserting) {
      context.missing(_savedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  PackagesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackagesTableData(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      latest: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}latest'])!,
      latestAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}latest_at']),
      preRelease: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pre_release']),
      preReleaseAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}pre_release_at']),
      sdks: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sdks'])!,
      platforms: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}platforms'])!,
      publisher: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}publisher'])!,
      points: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}points'])!,
      maxPoints: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_points'])!,
      likes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}likes'])!,
      popularity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}popularity'])!,
      savedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}saved_at'])!,
    );
  }

  @override
  $PackagesTableTable createAlias(String alias) {
    return $PackagesTableTable(attachedDatabase, alias);
  }
}

class PackagesTableData extends DataClass
    implements Insertable<PackagesTableData> {
  final String name;
  final String description;
  final String latest;
  final DateTime? latestAt;
  final String? preRelease;
  final DateTime? preReleaseAt;
  final String sdks;
  final String platforms;
  final String publisher;
  final int points;
  final int maxPoints;
  final int likes;
  final double popularity;
  final DateTime savedAt;
  const PackagesTableData(
      {required this.name,
      required this.description,
      required this.latest,
      this.latestAt,
      this.preRelease,
      this.preReleaseAt,
      required this.sdks,
      required this.platforms,
      required this.publisher,
      required this.points,
      required this.maxPoints,
      required this.likes,
      required this.popularity,
      required this.savedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['latest'] = Variable<String>(latest);
    if (!nullToAbsent || latestAt != null) {
      map['latest_at'] = Variable<DateTime>(latestAt);
    }
    if (!nullToAbsent || preRelease != null) {
      map['pre_release'] = Variable<String>(preRelease);
    }
    if (!nullToAbsent || preReleaseAt != null) {
      map['pre_release_at'] = Variable<DateTime>(preReleaseAt);
    }
    map['sdks'] = Variable<String>(sdks);
    map['platforms'] = Variable<String>(platforms);
    map['publisher'] = Variable<String>(publisher);
    map['points'] = Variable<int>(points);
    map['max_points'] = Variable<int>(maxPoints);
    map['likes'] = Variable<int>(likes);
    map['popularity'] = Variable<double>(popularity);
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  PackagesTableCompanion toCompanion(bool nullToAbsent) {
    return PackagesTableCompanion(
      name: Value(name),
      description: Value(description),
      latest: Value(latest),
      latestAt: latestAt == null && nullToAbsent
          ? const Value.absent()
          : Value(latestAt),
      preRelease: preRelease == null && nullToAbsent
          ? const Value.absent()
          : Value(preRelease),
      preReleaseAt: preReleaseAt == null && nullToAbsent
          ? const Value.absent()
          : Value(preReleaseAt),
      sdks: Value(sdks),
      platforms: Value(platforms),
      publisher: Value(publisher),
      points: Value(points),
      maxPoints: Value(maxPoints),
      likes: Value(likes),
      popularity: Value(popularity),
      savedAt: Value(savedAt),
    );
  }

  factory PackagesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackagesTableData(
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      latest: serializer.fromJson<String>(json['latest']),
      latestAt: serializer.fromJson<DateTime?>(json['latestAt']),
      preRelease: serializer.fromJson<String?>(json['preRelease']),
      preReleaseAt: serializer.fromJson<DateTime?>(json['preReleaseAt']),
      sdks: serializer.fromJson<String>(json['sdks']),
      platforms: serializer.fromJson<String>(json['platforms']),
      publisher: serializer.fromJson<String>(json['publisher']),
      points: serializer.fromJson<int>(json['points']),
      maxPoints: serializer.fromJson<int>(json['maxPoints']),
      likes: serializer.fromJson<int>(json['likes']),
      popularity: serializer.fromJson<double>(json['popularity']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'latest': serializer.toJson<String>(latest),
      'latestAt': serializer.toJson<DateTime?>(latestAt),
      'preRelease': serializer.toJson<String?>(preRelease),
      'preReleaseAt': serializer.toJson<DateTime?>(preReleaseAt),
      'sdks': serializer.toJson<String>(sdks),
      'platforms': serializer.toJson<String>(platforms),
      'publisher': serializer.toJson<String>(publisher),
      'points': serializer.toJson<int>(points),
      'maxPoints': serializer.toJson<int>(maxPoints),
      'likes': serializer.toJson<int>(likes),
      'popularity': serializer.toJson<double>(popularity),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  PackagesTableData copyWith(
          {String? name,
          String? description,
          String? latest,
          Value<DateTime?> latestAt = const Value.absent(),
          Value<String?> preRelease = const Value.absent(),
          Value<DateTime?> preReleaseAt = const Value.absent(),
          String? sdks,
          String? platforms,
          String? publisher,
          int? points,
          int? maxPoints,
          int? likes,
          double? popularity,
          DateTime? savedAt}) =>
      PackagesTableData(
        name: name ?? this.name,
        description: description ?? this.description,
        latest: latest ?? this.latest,
        latestAt: latestAt.present ? latestAt.value : this.latestAt,
        preRelease: preRelease.present ? preRelease.value : this.preRelease,
        preReleaseAt:
            preReleaseAt.present ? preReleaseAt.value : this.preReleaseAt,
        sdks: sdks ?? this.sdks,
        platforms: platforms ?? this.platforms,
        publisher: publisher ?? this.publisher,
        points: points ?? this.points,
        maxPoints: maxPoints ?? this.maxPoints,
        likes: likes ?? this.likes,
        popularity: popularity ?? this.popularity,
        savedAt: savedAt ?? this.savedAt,
      );
  @override
  String toString() {
    return (StringBuffer('PackagesTableData(')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('latest: $latest, ')
          ..write('latestAt: $latestAt, ')
          ..write('preRelease: $preRelease, ')
          ..write('preReleaseAt: $preReleaseAt, ')
          ..write('sdks: $sdks, ')
          ..write('platforms: $platforms, ')
          ..write('publisher: $publisher, ')
          ..write('points: $points, ')
          ..write('maxPoints: $maxPoints, ')
          ..write('likes: $likes, ')
          ..write('popularity: $popularity, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      name,
      description,
      latest,
      latestAt,
      preRelease,
      preReleaseAt,
      sdks,
      platforms,
      publisher,
      points,
      maxPoints,
      likes,
      popularity,
      savedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackagesTableData &&
          other.name == this.name &&
          other.description == this.description &&
          other.latest == this.latest &&
          other.latestAt == this.latestAt &&
          other.preRelease == this.preRelease &&
          other.preReleaseAt == this.preReleaseAt &&
          other.sdks == this.sdks &&
          other.platforms == this.platforms &&
          other.publisher == this.publisher &&
          other.points == this.points &&
          other.maxPoints == this.maxPoints &&
          other.likes == this.likes &&
          other.popularity == this.popularity &&
          other.savedAt == this.savedAt);
}

class PackagesTableCompanion extends UpdateCompanion<PackagesTableData> {
  final Value<String> name;
  final Value<String> description;
  final Value<String> latest;
  final Value<DateTime?> latestAt;
  final Value<String?> preRelease;
  final Value<DateTime?> preReleaseAt;
  final Value<String> sdks;
  final Value<String> platforms;
  final Value<String> publisher;
  final Value<int> points;
  final Value<int> maxPoints;
  final Value<int> likes;
  final Value<double> popularity;
  final Value<DateTime> savedAt;
  final Value<int> rowid;
  const PackagesTableCompanion({
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.latest = const Value.absent(),
    this.latestAt = const Value.absent(),
    this.preRelease = const Value.absent(),
    this.preReleaseAt = const Value.absent(),
    this.sdks = const Value.absent(),
    this.platforms = const Value.absent(),
    this.publisher = const Value.absent(),
    this.points = const Value.absent(),
    this.maxPoints = const Value.absent(),
    this.likes = const Value.absent(),
    this.popularity = const Value.absent(),
    this.savedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PackagesTableCompanion.insert({
    required String name,
    required String description,
    required String latest,
    this.latestAt = const Value.absent(),
    this.preRelease = const Value.absent(),
    this.preReleaseAt = const Value.absent(),
    required String sdks,
    required String platforms,
    required String publisher,
    required int points,
    required int maxPoints,
    required int likes,
    required double popularity,
    required DateTime savedAt,
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        description = Value(description),
        latest = Value(latest),
        sdks = Value(sdks),
        platforms = Value(platforms),
        publisher = Value(publisher),
        points = Value(points),
        maxPoints = Value(maxPoints),
        likes = Value(likes),
        popularity = Value(popularity),
        savedAt = Value(savedAt);
  static Insertable<PackagesTableData> custom({
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? latest,
    Expression<DateTime>? latestAt,
    Expression<String>? preRelease,
    Expression<DateTime>? preReleaseAt,
    Expression<String>? sdks,
    Expression<String>? platforms,
    Expression<String>? publisher,
    Expression<int>? points,
    Expression<int>? maxPoints,
    Expression<int>? likes,
    Expression<double>? popularity,
    Expression<DateTime>? savedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (latest != null) 'latest': latest,
      if (latestAt != null) 'latest_at': latestAt,
      if (preRelease != null) 'pre_release': preRelease,
      if (preReleaseAt != null) 'pre_release_at': preReleaseAt,
      if (sdks != null) 'sdks': sdks,
      if (platforms != null) 'platforms': platforms,
      if (publisher != null) 'publisher': publisher,
      if (points != null) 'points': points,
      if (maxPoints != null) 'max_points': maxPoints,
      if (likes != null) 'likes': likes,
      if (popularity != null) 'popularity': popularity,
      if (savedAt != null) 'saved_at': savedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PackagesTableCompanion copyWith(
      {Value<String>? name,
      Value<String>? description,
      Value<String>? latest,
      Value<DateTime?>? latestAt,
      Value<String?>? preRelease,
      Value<DateTime?>? preReleaseAt,
      Value<String>? sdks,
      Value<String>? platforms,
      Value<String>? publisher,
      Value<int>? points,
      Value<int>? maxPoints,
      Value<int>? likes,
      Value<double>? popularity,
      Value<DateTime>? savedAt,
      Value<int>? rowid}) {
    return PackagesTableCompanion(
      name: name ?? this.name,
      description: description ?? this.description,
      latest: latest ?? this.latest,
      latestAt: latestAt ?? this.latestAt,
      preRelease: preRelease ?? this.preRelease,
      preReleaseAt: preReleaseAt ?? this.preReleaseAt,
      sdks: sdks ?? this.sdks,
      platforms: platforms ?? this.platforms,
      publisher: publisher ?? this.publisher,
      points: points ?? this.points,
      maxPoints: maxPoints ?? this.maxPoints,
      likes: likes ?? this.likes,
      popularity: popularity ?? this.popularity,
      savedAt: savedAt ?? this.savedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (latest.present) {
      map['latest'] = Variable<String>(latest.value);
    }
    if (latestAt.present) {
      map['latest_at'] = Variable<DateTime>(latestAt.value);
    }
    if (preRelease.present) {
      map['pre_release'] = Variable<String>(preRelease.value);
    }
    if (preReleaseAt.present) {
      map['pre_release_at'] = Variable<DateTime>(preReleaseAt.value);
    }
    if (sdks.present) {
      map['sdks'] = Variable<String>(sdks.value);
    }
    if (platforms.present) {
      map['platforms'] = Variable<String>(platforms.value);
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (maxPoints.present) {
      map['max_points'] = Variable<int>(maxPoints.value);
    }
    if (likes.present) {
      map['likes'] = Variable<int>(likes.value);
    }
    if (popularity.present) {
      map['popularity'] = Variable<double>(popularity.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackagesTableCompanion(')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('latest: $latest, ')
          ..write('latestAt: $latestAt, ')
          ..write('preRelease: $preRelease, ')
          ..write('preReleaseAt: $preReleaseAt, ')
          ..write('sdks: $sdks, ')
          ..write('platforms: $platforms, ')
          ..write('publisher: $publisher, ')
          ..write('points: $points, ')
          ..write('maxPoints: $maxPoints, ')
          ..write('likes: $likes, ')
          ..write('popularity: $popularity, ')
          ..write('savedAt: $savedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTableTable extends BookmarksTable
    with TableInfo<$BookmarksTableTable, BookmarksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks_table';
  @override
  VerificationContext validateIntegrity(Insertable<BookmarksTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  BookmarksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookmarksTableData(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BookmarksTableTable createAlias(String alias) {
    return $BookmarksTableTable(attachedDatabase, alias);
  }
}

class BookmarksTableData extends DataClass
    implements Insertable<BookmarksTableData> {
  final String name;
  final DateTime createdAt;
  const BookmarksTableData({required this.name, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarksTableCompanion toCompanion(bool nullToAbsent) {
    return BookmarksTableCompanion(
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory BookmarksTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookmarksTableData(
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BookmarksTableData copyWith({String? name, DateTime? createdAt}) =>
      BookmarksTableData(
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('BookmarksTableData(')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookmarksTableData &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class BookmarksTableCompanion extends UpdateCompanion<BookmarksTableData> {
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const BookmarksTableCompanion({
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookmarksTableCompanion.insert({
    required String name,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        createdAt = Value(createdAt);
  static Insertable<BookmarksTableData> custom({
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookmarksTableCompanion copyWith(
      {Value<String>? name, Value<DateTime>? createdAt, Value<int>? rowid}) {
    return BookmarksTableCompanion(
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksTableCompanion(')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class PackagesWithBookmarkData extends DataClass {
  final String name;
  final String description;
  final String latest;
  final DateTime? latestAt;
  final String? preRelease;
  final DateTime? preReleaseAt;
  final String sdks;
  final String platforms;
  final String publisher;
  final int points;
  final int maxPoints;
  final int likes;
  final double popularity;
  final DateTime savedAt;
  final DateTime? bookmarkedAt;
  const PackagesWithBookmarkData(
      {required this.name,
      required this.description,
      required this.latest,
      this.latestAt,
      this.preRelease,
      this.preReleaseAt,
      required this.sdks,
      required this.platforms,
      required this.publisher,
      required this.points,
      required this.maxPoints,
      required this.likes,
      required this.popularity,
      required this.savedAt,
      this.bookmarkedAt});
  factory PackagesWithBookmarkData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackagesWithBookmarkData(
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      latest: serializer.fromJson<String>(json['latest']),
      latestAt: serializer.fromJson<DateTime?>(json['latestAt']),
      preRelease: serializer.fromJson<String?>(json['preRelease']),
      preReleaseAt: serializer.fromJson<DateTime?>(json['preReleaseAt']),
      sdks: serializer.fromJson<String>(json['sdks']),
      platforms: serializer.fromJson<String>(json['platforms']),
      publisher: serializer.fromJson<String>(json['publisher']),
      points: serializer.fromJson<int>(json['points']),
      maxPoints: serializer.fromJson<int>(json['maxPoints']),
      likes: serializer.fromJson<int>(json['likes']),
      popularity: serializer.fromJson<double>(json['popularity']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
      bookmarkedAt: serializer.fromJson<DateTime?>(json['bookmarkedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'latest': serializer.toJson<String>(latest),
      'latestAt': serializer.toJson<DateTime?>(latestAt),
      'preRelease': serializer.toJson<String?>(preRelease),
      'preReleaseAt': serializer.toJson<DateTime?>(preReleaseAt),
      'sdks': serializer.toJson<String>(sdks),
      'platforms': serializer.toJson<String>(platforms),
      'publisher': serializer.toJson<String>(publisher),
      'points': serializer.toJson<int>(points),
      'maxPoints': serializer.toJson<int>(maxPoints),
      'likes': serializer.toJson<int>(likes),
      'popularity': serializer.toJson<double>(popularity),
      'savedAt': serializer.toJson<DateTime>(savedAt),
      'bookmarkedAt': serializer.toJson<DateTime?>(bookmarkedAt),
    };
  }

  PackagesWithBookmarkData copyWith(
          {String? name,
          String? description,
          String? latest,
          Value<DateTime?> latestAt = const Value.absent(),
          Value<String?> preRelease = const Value.absent(),
          Value<DateTime?> preReleaseAt = const Value.absent(),
          String? sdks,
          String? platforms,
          String? publisher,
          int? points,
          int? maxPoints,
          int? likes,
          double? popularity,
          DateTime? savedAt,
          Value<DateTime?> bookmarkedAt = const Value.absent()}) =>
      PackagesWithBookmarkData(
        name: name ?? this.name,
        description: description ?? this.description,
        latest: latest ?? this.latest,
        latestAt: latestAt.present ? latestAt.value : this.latestAt,
        preRelease: preRelease.present ? preRelease.value : this.preRelease,
        preReleaseAt:
            preReleaseAt.present ? preReleaseAt.value : this.preReleaseAt,
        sdks: sdks ?? this.sdks,
        platforms: platforms ?? this.platforms,
        publisher: publisher ?? this.publisher,
        points: points ?? this.points,
        maxPoints: maxPoints ?? this.maxPoints,
        likes: likes ?? this.likes,
        popularity: popularity ?? this.popularity,
        savedAt: savedAt ?? this.savedAt,
        bookmarkedAt:
            bookmarkedAt.present ? bookmarkedAt.value : this.bookmarkedAt,
      );
  @override
  String toString() {
    return (StringBuffer('PackagesWithBookmarkData(')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('latest: $latest, ')
          ..write('latestAt: $latestAt, ')
          ..write('preRelease: $preRelease, ')
          ..write('preReleaseAt: $preReleaseAt, ')
          ..write('sdks: $sdks, ')
          ..write('platforms: $platforms, ')
          ..write('publisher: $publisher, ')
          ..write('points: $points, ')
          ..write('maxPoints: $maxPoints, ')
          ..write('likes: $likes, ')
          ..write('popularity: $popularity, ')
          ..write('savedAt: $savedAt, ')
          ..write('bookmarkedAt: $bookmarkedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      name,
      description,
      latest,
      latestAt,
      preRelease,
      preReleaseAt,
      sdks,
      platforms,
      publisher,
      points,
      maxPoints,
      likes,
      popularity,
      savedAt,
      bookmarkedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackagesWithBookmarkData &&
          other.name == this.name &&
          other.description == this.description &&
          other.latest == this.latest &&
          other.latestAt == this.latestAt &&
          other.preRelease == this.preRelease &&
          other.preReleaseAt == this.preReleaseAt &&
          other.sdks == this.sdks &&
          other.platforms == this.platforms &&
          other.publisher == this.publisher &&
          other.points == this.points &&
          other.maxPoints == this.maxPoints &&
          other.likes == this.likes &&
          other.popularity == this.popularity &&
          other.savedAt == this.savedAt &&
          other.bookmarkedAt == this.bookmarkedAt);
}

class $PackagesWithBookmarkView
    extends ViewInfo<$PackagesWithBookmarkView, PackagesWithBookmarkData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$Database attachedDatabase;
  $PackagesWithBookmarkView(this.attachedDatabase, [this._alias]);
  $PackagesTableTable get packages =>
      attachedDatabase.packagesTable.createAlias('t0');
  $BookmarksTableTable get bookmarks =>
      attachedDatabase.bookmarksTable.createAlias('t1');
  @override
  List<GeneratedColumn> get $columns => [
        name,
        description,
        latest,
        latestAt,
        preRelease,
        preReleaseAt,
        sdks,
        platforms,
        publisher,
        points,
        maxPoints,
        likes,
        popularity,
        savedAt,
        bookmarkedAt
      ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'packages_with_bookmark';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $PackagesWithBookmarkView get asDslTable => this;
  @override
  PackagesWithBookmarkData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackagesWithBookmarkData(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      latest: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}latest'])!,
      latestAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}latest_at']),
      preRelease: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pre_release']),
      preReleaseAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}pre_release_at']),
      sdks: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sdks'])!,
      platforms: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}platforms'])!,
      publisher: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}publisher'])!,
      points: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}points'])!,
      maxPoints: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_points'])!,
      likes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}likes'])!,
      popularity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}popularity'])!,
      savedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}saved_at'])!,
      bookmarkedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}bookmarked_at']),
    );
  }

  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      generatedAs: GeneratedAs(packages.name, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      generatedAs: GeneratedAs(packages.description, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> latest = GeneratedColumn<String>(
      'latest', aliasedName, false,
      generatedAs: GeneratedAs(packages.latest, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<DateTime> latestAt = GeneratedColumn<DateTime>(
      'latest_at', aliasedName, true,
      generatedAs: GeneratedAs(packages.latestAt, false),
      type: DriftSqlType.dateTime);
  late final GeneratedColumn<String> preRelease = GeneratedColumn<String>(
      'pre_release', aliasedName, true,
      generatedAs: GeneratedAs(packages.preRelease, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<DateTime> preReleaseAt = GeneratedColumn<DateTime>(
      'pre_release_at', aliasedName, true,
      generatedAs: GeneratedAs(packages.preReleaseAt, false),
      type: DriftSqlType.dateTime);
  late final GeneratedColumn<String> sdks = GeneratedColumn<String>(
      'sdks', aliasedName, false,
      generatedAs: GeneratedAs(packages.sdks, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> platforms = GeneratedColumn<String>(
      'platforms', aliasedName, false,
      generatedAs: GeneratedAs(packages.platforms, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
      'publisher', aliasedName, false,
      generatedAs: GeneratedAs(packages.publisher, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
      'points', aliasedName, false,
      generatedAs: GeneratedAs(packages.points, false), type: DriftSqlType.int);
  late final GeneratedColumn<int> maxPoints = GeneratedColumn<int>(
      'max_points', aliasedName, false,
      generatedAs: GeneratedAs(packages.maxPoints, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> likes = GeneratedColumn<int>(
      'likes', aliasedName, false,
      generatedAs: GeneratedAs(packages.likes, false), type: DriftSqlType.int);
  late final GeneratedColumn<double> popularity = GeneratedColumn<double>(
      'popularity', aliasedName, false,
      generatedAs: GeneratedAs(packages.popularity, false),
      type: DriftSqlType.double);
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
      'saved_at', aliasedName, false,
      generatedAs: GeneratedAs(packages.savedAt, false),
      type: DriftSqlType.dateTime);
  late final GeneratedColumn<DateTime> bookmarkedAt = GeneratedColumn<DateTime>(
      'bookmarked_at', aliasedName, true,
      generatedAs: GeneratedAs(bookmarks.createdAt, false),
      type: DriftSqlType.dateTime);
  @override
  $PackagesWithBookmarkView createAlias(String alias) {
    return $PackagesWithBookmarkView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(packages)..addColumns($columns)).join(
          [leftOuterJoin(bookmarks, bookmarks.name.equalsExp(packages.name))]);
  @override
  Set<String> get readTables => const {'packages_table', 'bookmarks_table'};
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  _$DatabaseManager get managers => _$DatabaseManager(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  late final $PackagesTableTable packagesTable = $PackagesTableTable(this);
  late final $BookmarksTableTable bookmarksTable = $BookmarksTableTable(this);
  late final $PackagesWithBookmarkView packagesWithBookmark =
      $PackagesWithBookmarkView(this);
  late final SettingsDao settingsDao = SettingsDao(this as Database);
  late final PackagesDao packagesDao = PackagesDao(this as Database);
  late final BookmarksDao bookmarksDao = BookmarksDao(this as Database);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [settingsTable, packagesTable, bookmarksTable, packagesWithBookmark];
}

typedef $$SettingsTableTableInsertCompanionBuilder = SettingsTableCompanion
    Function({
  Value<int> id,
  Value<int> themeModeIndex,
});
typedef $$SettingsTableTableUpdateCompanionBuilder = SettingsTableCompanion
    Function({
  Value<int> id,
  Value<int> themeModeIndex,
});

class $$SettingsTableTableTableManager extends RootTableManager<
    _$Database,
    $SettingsTableTable,
    SettingsTableData,
    $$SettingsTableTableFilterComposer,
    $$SettingsTableTableOrderingComposer,
    $$SettingsTableTableProcessedTableManager,
    $$SettingsTableTableInsertCompanionBuilder,
    $$SettingsTableTableUpdateCompanionBuilder> {
  $$SettingsTableTableTableManager(_$Database db, $SettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SettingsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SettingsTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$SettingsTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> themeModeIndex = const Value.absent(),
          }) =>
              SettingsTableCompanion(
            id: id,
            themeModeIndex: themeModeIndex,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> themeModeIndex = const Value.absent(),
          }) =>
              SettingsTableCompanion.insert(
            id: id,
            themeModeIndex: themeModeIndex,
          ),
        ));
}

class $$SettingsTableTableProcessedTableManager extends ProcessedTableManager<
    _$Database,
    $SettingsTableTable,
    SettingsTableData,
    $$SettingsTableTableFilterComposer,
    $$SettingsTableTableOrderingComposer,
    $$SettingsTableTableProcessedTableManager,
    $$SettingsTableTableInsertCompanionBuilder,
    $$SettingsTableTableUpdateCompanionBuilder> {
  $$SettingsTableTableProcessedTableManager(super.$state);
}

class $$SettingsTableTableFilterComposer
    extends FilterComposer<_$Database, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get themeModeIndex => $state.composableBuilder(
      column: $state.table.themeModeIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SettingsTableTableOrderingComposer
    extends OrderingComposer<_$Database, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get themeModeIndex => $state.composableBuilder(
      column: $state.table.themeModeIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PackagesTableTableInsertCompanionBuilder = PackagesTableCompanion
    Function({
  required String name,
  required String description,
  required String latest,
  Value<DateTime?> latestAt,
  Value<String?> preRelease,
  Value<DateTime?> preReleaseAt,
  required String sdks,
  required String platforms,
  required String publisher,
  required int points,
  required int maxPoints,
  required int likes,
  required double popularity,
  required DateTime savedAt,
  Value<int> rowid,
});
typedef $$PackagesTableTableUpdateCompanionBuilder = PackagesTableCompanion
    Function({
  Value<String> name,
  Value<String> description,
  Value<String> latest,
  Value<DateTime?> latestAt,
  Value<String?> preRelease,
  Value<DateTime?> preReleaseAt,
  Value<String> sdks,
  Value<String> platforms,
  Value<String> publisher,
  Value<int> points,
  Value<int> maxPoints,
  Value<int> likes,
  Value<double> popularity,
  Value<DateTime> savedAt,
  Value<int> rowid,
});

class $$PackagesTableTableTableManager extends RootTableManager<
    _$Database,
    $PackagesTableTable,
    PackagesTableData,
    $$PackagesTableTableFilterComposer,
    $$PackagesTableTableOrderingComposer,
    $$PackagesTableTableProcessedTableManager,
    $$PackagesTableTableInsertCompanionBuilder,
    $$PackagesTableTableUpdateCompanionBuilder> {
  $$PackagesTableTableTableManager(_$Database db, $PackagesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PackagesTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PackagesTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$PackagesTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> latest = const Value.absent(),
            Value<DateTime?> latestAt = const Value.absent(),
            Value<String?> preRelease = const Value.absent(),
            Value<DateTime?> preReleaseAt = const Value.absent(),
            Value<String> sdks = const Value.absent(),
            Value<String> platforms = const Value.absent(),
            Value<String> publisher = const Value.absent(),
            Value<int> points = const Value.absent(),
            Value<int> maxPoints = const Value.absent(),
            Value<int> likes = const Value.absent(),
            Value<double> popularity = const Value.absent(),
            Value<DateTime> savedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PackagesTableCompanion(
            name: name,
            description: description,
            latest: latest,
            latestAt: latestAt,
            preRelease: preRelease,
            preReleaseAt: preReleaseAt,
            sdks: sdks,
            platforms: platforms,
            publisher: publisher,
            points: points,
            maxPoints: maxPoints,
            likes: likes,
            popularity: popularity,
            savedAt: savedAt,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String name,
            required String description,
            required String latest,
            Value<DateTime?> latestAt = const Value.absent(),
            Value<String?> preRelease = const Value.absent(),
            Value<DateTime?> preReleaseAt = const Value.absent(),
            required String sdks,
            required String platforms,
            required String publisher,
            required int points,
            required int maxPoints,
            required int likes,
            required double popularity,
            required DateTime savedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PackagesTableCompanion.insert(
            name: name,
            description: description,
            latest: latest,
            latestAt: latestAt,
            preRelease: preRelease,
            preReleaseAt: preReleaseAt,
            sdks: sdks,
            platforms: platforms,
            publisher: publisher,
            points: points,
            maxPoints: maxPoints,
            likes: likes,
            popularity: popularity,
            savedAt: savedAt,
            rowid: rowid,
          ),
        ));
}

class $$PackagesTableTableProcessedTableManager extends ProcessedTableManager<
    _$Database,
    $PackagesTableTable,
    PackagesTableData,
    $$PackagesTableTableFilterComposer,
    $$PackagesTableTableOrderingComposer,
    $$PackagesTableTableProcessedTableManager,
    $$PackagesTableTableInsertCompanionBuilder,
    $$PackagesTableTableUpdateCompanionBuilder> {
  $$PackagesTableTableProcessedTableManager(super.$state);
}

class $$PackagesTableTableFilterComposer
    extends FilterComposer<_$Database, $PackagesTableTable> {
  $$PackagesTableTableFilterComposer(super.$state);
  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get latest => $state.composableBuilder(
      column: $state.table.latest,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get latestAt => $state.composableBuilder(
      column: $state.table.latestAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get preRelease => $state.composableBuilder(
      column: $state.table.preRelease,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get preReleaseAt => $state.composableBuilder(
      column: $state.table.preReleaseAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sdks => $state.composableBuilder(
      column: $state.table.sdks,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get platforms => $state.composableBuilder(
      column: $state.table.platforms,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get publisher => $state.composableBuilder(
      column: $state.table.publisher,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get points => $state.composableBuilder(
      column: $state.table.points,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get maxPoints => $state.composableBuilder(
      column: $state.table.maxPoints,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get likes => $state.composableBuilder(
      column: $state.table.likes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get popularity => $state.composableBuilder(
      column: $state.table.popularity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get savedAt => $state.composableBuilder(
      column: $state.table.savedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$PackagesTableTableOrderingComposer
    extends OrderingComposer<_$Database, $PackagesTableTable> {
  $$PackagesTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get latest => $state.composableBuilder(
      column: $state.table.latest,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get latestAt => $state.composableBuilder(
      column: $state.table.latestAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get preRelease => $state.composableBuilder(
      column: $state.table.preRelease,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get preReleaseAt => $state.composableBuilder(
      column: $state.table.preReleaseAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sdks => $state.composableBuilder(
      column: $state.table.sdks,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get platforms => $state.composableBuilder(
      column: $state.table.platforms,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get publisher => $state.composableBuilder(
      column: $state.table.publisher,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get points => $state.composableBuilder(
      column: $state.table.points,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get maxPoints => $state.composableBuilder(
      column: $state.table.maxPoints,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get likes => $state.composableBuilder(
      column: $state.table.likes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get popularity => $state.composableBuilder(
      column: $state.table.popularity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get savedAt => $state.composableBuilder(
      column: $state.table.savedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$BookmarksTableTableInsertCompanionBuilder = BookmarksTableCompanion
    Function({
  required String name,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$BookmarksTableTableUpdateCompanionBuilder = BookmarksTableCompanion
    Function({
  Value<String> name,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$BookmarksTableTableTableManager extends RootTableManager<
    _$Database,
    $BookmarksTableTable,
    BookmarksTableData,
    $$BookmarksTableTableFilterComposer,
    $$BookmarksTableTableOrderingComposer,
    $$BookmarksTableTableProcessedTableManager,
    $$BookmarksTableTableInsertCompanionBuilder,
    $$BookmarksTableTableUpdateCompanionBuilder> {
  $$BookmarksTableTableTableManager(_$Database db, $BookmarksTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BookmarksTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$BookmarksTableTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$BookmarksTableTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> name = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BookmarksTableCompanion(
            name: name,
            createdAt: createdAt,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String name,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              BookmarksTableCompanion.insert(
            name: name,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$BookmarksTableTableProcessedTableManager extends ProcessedTableManager<
    _$Database,
    $BookmarksTableTable,
    BookmarksTableData,
    $$BookmarksTableTableFilterComposer,
    $$BookmarksTableTableOrderingComposer,
    $$BookmarksTableTableProcessedTableManager,
    $$BookmarksTableTableInsertCompanionBuilder,
    $$BookmarksTableTableUpdateCompanionBuilder> {
  $$BookmarksTableTableProcessedTableManager(super.$state);
}

class $$BookmarksTableTableFilterComposer
    extends FilterComposer<_$Database, $BookmarksTableTable> {
  $$BookmarksTableTableFilterComposer(super.$state);
  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$BookmarksTableTableOrderingComposer
    extends OrderingComposer<_$Database, $BookmarksTableTable> {
  $$BookmarksTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$DatabaseManager {
  final _$Database _db;
  _$DatabaseManager(this._db);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
  $$PackagesTableTableTableManager get packagesTable =>
      $$PackagesTableTableTableManager(_db, _db.packagesTable);
  $$BookmarksTableTableTableManager get bookmarksTable =>
      $$BookmarksTableTableTableManager(_db, _db.bookmarksTable);
}
