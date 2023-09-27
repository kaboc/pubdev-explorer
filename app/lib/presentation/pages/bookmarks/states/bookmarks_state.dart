import 'package:equatable/equatable.dart';

class BookmarksState extends Equatable {
  const BookmarksState({
    this.packageNames = const {},
    this.keywords = const [],
    this.hasMore = false,
  });

  final Set<String> packageNames;
  final List<String> keywords;
  final bool hasMore;

  @override
  List<Object> get props => [packageNames, keywords, hasMore];

  BookmarksState copyWith({
    Set<String>? packageNames,
    List<String>? keywords,
    bool? hasMore,
  }) {
    return BookmarksState(
      packageNames: packageNames ?? this.packageNames,
      keywords: keywords ?? this.keywords,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
