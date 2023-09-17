import 'package:equatable/equatable.dart';

class BookmarksState extends Equatable {
  const BookmarksState({
    this.packageNames = const {},
    this.searchWords = const [],
    this.hasMore = false,
  });

  final Set<String> packageNames;
  final List<String> searchWords;
  final bool hasMore;

  @override
  List<Object> get props => [packageNames, searchWords, hasMore];

  BookmarksState copyWith({
    Set<String>? packageNames,
    List<String>? searchWords,
    bool? hasMore,
  }) {
    return BookmarksState(
      packageNames: packageNames ?? this.packageNames,
      searchWords: searchWords ?? this.searchWords,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
