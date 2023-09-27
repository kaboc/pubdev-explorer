import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
    this.packageNames = const {},
    this.page = 0,
    this.index = 0,
    this.hasMore = true,
    this.keywords,
  });

  final Set<String> packageNames;
  final int page;
  final int index;
  final bool hasMore;
  final List<String>? keywords;

  @override
  List<Object?> get props => [packageNames, page, index, hasMore, keywords];

  bool get isFirst => index == 0;
  bool get isLast => index >= packageNames.length - 1;
  bool get isIndexOutOfRange => index < 0 || index >= packageNames.length;
  String get currentPackageName => packageNameAt(index);

  String packageNameAt(int index) {
    return isIndexOutOfRange ? '' : packageNames.elementAtOrNull(index) ?? '';
  }

  HomeState copyWith({
    Set<String>? packageNames,
    int? page,
    int? index,
    bool? hasMore,
    List<String>? keywords,
  }) {
    return HomeState(
      packageNames: packageNames ?? this.packageNames,
      page: page ?? this.page,
      index: index ?? this.index,
      hasMore: hasMore ?? this.hasMore,
      keywords: keywords ?? this.keywords,
    );
  }
}
