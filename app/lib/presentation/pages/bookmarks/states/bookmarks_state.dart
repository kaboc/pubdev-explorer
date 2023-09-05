import 'package:equatable/equatable.dart';

import 'package:pubdev_explorer/common/_common.dart';

export 'package:async_phase_notifier/async_phase.dart';

class BookmarksState extends Equatable {
  const BookmarksState({
    this.packagePhases = const [],
    this.searchWords = const [],
    this.hasMore = false,
  });

  final List<AsyncPhase<Package>> packagePhases;
  final List<String> searchWords;
  final bool hasMore;

  @override
  List<Object> get props => [packagePhases, searchWords, hasMore];

  BookmarksState copyWith({
    List<AsyncPhase<Package>>? packagePhases,
    List<String>? searchWords,
    bool? hasMore,
  }) {
    return BookmarksState(
      packagePhases: packagePhases ?? this.packagePhases,
      searchWords: searchWords ?? this.searchWords,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
