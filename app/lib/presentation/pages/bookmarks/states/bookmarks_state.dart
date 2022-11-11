import 'package:equatable/equatable.dart';

import 'package:pubdev_explorer/common/_common.dart';

export 'package:async_phase_notifier/async_phase.dart';

class BookmarksState extends Equatable {
  const BookmarksState({
    this.packagePhases = const [],
    this.searchWords = const [],
  });

  final List<AsyncPhase<Package>> packagePhases;
  final List<String> searchWords;

  @override
  List<Object> get props => [packagePhases, searchWords];

  BookmarksState copyWith({
    List<AsyncPhase<Package>>? packagePhases,
    List<String>? searchWords,
  }) {
    return BookmarksState(
      packagePhases: packagePhases ?? this.packagePhases,
      searchWords: searchWords ?? this.searchWords,
    );
  }
}
