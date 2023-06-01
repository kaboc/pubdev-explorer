import 'package:equatable/equatable.dart';

import 'package:pubdev_explorer/common/_common.dart';
import 'package:pubdev_explorer/presentation/common/_common.dart';

export 'package:async_phase_notifier/async_phase.dart';

class HomeState extends Equatable {
  const HomeState({
    this.packagePhases = const [],
    this.page = 0,
    this.index = 0,
    this.endReached = false,
  });

  final List<AsyncPhase<Package>> packagePhases;
  final int page;
  final int index;
  final bool endReached;

  @override
  List<Object> get props => [packagePhases, page, index, endReached];

  bool get isFirst => index == 0;
  bool get isLast => index >= packagePhases.length - 1;
  bool get isIndexOutOfRange => index >= packagePhases.length;
  Package? get currentPackage => packagePhases.at(index)?.data;

  HomeState copyWith({
    List<AsyncPhase<Package>>? packagePhases,
    int? page,
    int? index,
    bool? endReached,
  }) {
    return HomeState(
      packagePhases: packagePhases ?? this.packagePhases,
      page: page ?? this.page,
      index: index ?? this.index,
      endReached: endReached ?? this.endReached,
    );
  }
}
