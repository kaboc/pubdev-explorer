import 'package:equatable/equatable.dart';

import 'package:pubdev_explorer_core/src/domain/pub/models/enums.dart';
import 'package:pubdev_explorer_core/src/domain/pub/models/version.dart';

class Package extends Equatable {
  const Package({
    this.name = '',
    this.description = '',
    this.latest = const Version.none(),
    this.preRelease = const Version.none(),
    this.sdks = const [],
    this.platforms = const [],
    this.publisher = '',
    this.points = 0,
    this.maxPoints = 0,
    this.likes = 0,
    this.popularity = 0.0,
    this.savedAt,
    this.bookmarkedAt,
  });

  const factory Package.none() = Package;

  final String name;
  final String description;
  final Version latest;
  final Version? preRelease;
  final Iterable<Sdk> sdks;
  final Iterable<Platform> platforms;
  final String publisher;
  final int points;
  final int maxPoints;
  final int likes;
  final double popularity;
  final DateTime? savedAt;
  final DateTime? bookmarkedAt;

  @override
  List<Object?> get props => [
        name,
        description,
        latest,
        preRelease,
        sdks,
        platforms,
        publisher,
        points,
        maxPoints,
        likes,
        popularity,
        savedAt,
        bookmarkedAt,
      ];

  bool get isNone => this == const Package.none();
  bool get isEmpty => description.isEmpty;
  int get roundedPopularity => (popularity * 100).round();
  bool get isBookmarked => bookmarkedAt != null;

  Package copyWith({
    String? name,
    String? description,
    Version? latest,
    Version? preRelease,
    Iterable<Sdk>? sdks,
    Iterable<Platform>? platforms,
    String? publisher,
    int? points,
    int? maxPoints,
    int? likes,
    double? popularity,
    DateTime? savedAt,
    bool? bookmarked,
  }) {
    return Package(
      name: name ?? this.name,
      description: description ?? this.description,
      latest: latest ?? this.latest,
      preRelease: preRelease ?? this.preRelease,
      sdks: sdks ?? this.sdks,
      platforms: platforms ?? this.platforms,
      publisher: publisher ?? this.publisher,
      points: points ?? this.points,
      maxPoints: maxPoints ?? this.maxPoints,
      likes: likes ?? this.likes,
      popularity: popularity ?? this.popularity,
      savedAt: savedAt ?? this.savedAt,
      bookmarkedAt: bookmarked == null
          ? bookmarkedAt
          : (bookmarked ? DateTime.now() : null),
    );
  }
}
